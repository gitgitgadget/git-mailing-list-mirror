From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git_blame2: fix rendering on Firefox 3.0b5
Date: Tue, 22 Apr 2008 20:45:31 +0200
Message-ID: <200804222045.32416.jnareb@gmail.com>
References: <1208821391-7895-1-git-send-email-stevenrwalter@gmail.com> <200804221905.41963.jnareb@gmail.com> <e06498070804221046j5b9d4edbwe798ddb44f4fecf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steven Walter" <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:47:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoNVv-0008Hc-1G
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 20:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbYDVSpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 14:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756396AbYDVSpr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 14:45:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:57144 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755333AbYDVSpp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 14:45:45 -0400
Received: by ug-out-1314.google.com with SMTP id z38so218979ugc.16
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=P+xz7SraebwssFHJY4mjX0Ttc1B43MzwSWaUPBTaX4Q=;
        b=A1Xs+/rwytuf8AMPlIU7q4R1aw+m5JSbwhbCW/xv2R/HSlidTwMNmih6CfSQ5m+rQ4gDyT09omf8jdiQuXo4JBQGcfQWX7BfZnYYIypQQKx2B4nT1dd1AhIyg5lXUisndxF9vZW8OrtHzgfoWsmIInJwbV4F29DrtUl3u4yXeFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pS074CgoBwPMjRM5wg2l2K/2jY7eEJsJL15uLOW1uz09cfddRGWKSBqg+jCN8KNQRYvXiyU5sEY4+nlpXATYGQA1gJNl5C8hqs/hsNdzAqK6oBq1xfzyMngbXHB+0qPKzS0OGTv0R8z9m3XhHA8yxN7cua1nbNOMNUYNdn9FVIE=
Received: by 10.67.116.9 with SMTP id t9mr7216773ugm.77.1208889943050;
        Tue, 22 Apr 2008 11:45:43 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.207])
        by mx.google.com with ESMTPS id 24sm602666ugf.22.2008.04.22.11.45.38
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Apr 2008 11:45:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <e06498070804221046j5b9d4edbwe798ddb44f4fecf8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80157>

On Tue, 22 April 2008, Steven Walter wrote:
> On Tue, Apr 22, 2008 at 1:05 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Tue, 22 April 2008, stevenrwalter@gmail.com wrote:
>>>
>>> Using variably-sized rows and rowspan does not render correctly with
>>> Firefox 3.0b5.  Instead, make each row have the same number of cells.
>>
>>  Beta version of Firefox doesn't correctly render perfectly valid HTML;
>>  more, the way rowspan was meanto to be used, see example in
>>
>>   http://www.w3.org/TR/html401/struct/tables.html#h-11.2.6.1
>>   (subsection "Cells that span several rows or columns" in HTML 4.01)
>>
>>  and you want gitweb to generate invalid HTML?
> 
> What's invalid about the way my patch generated HTML?  It renders
> correctly on both FF2 and FF3.

The fact that HTML is valid or not is not dependent on the fact that
some web browser, or some beta version of web browser (which can have
bugs), renders it correctly or not.  You check if HTML is valid against
HTML specification, e.g. using one of online HTML validators, including
W3C Validator or WDG Validator.

> It may have been fully correct before, but is it any less correct now?

The idea is that enlarged cell (either via rowspan, or via colspan),
takes place / pushes out other cells.  Se the ASCII-art diagram (to be
viewed using fixed-width, non-proportinal font) below:

   |-----|-----|
   |  A  |  B  |   <tr><td rowspan="2"> A </td><td> B </td></tr>
   |     |-----|
   |     |  C  |   <tr><!--   space for A   --><td> C </td></tr>
   |-----|-----|
  
See example in provided link to HTML specification.  It is natural way
of writing HTML table with cell spanning multiple rows.

> Conversely, I will also file a bug with Firefox regarding it's
> apparently-broken handling of rowspan.

If handling of rowspan differs from handling colspan with respect to
variable number of cells in row / column, then it is certainly a bug.
Gitweb don't use colspan beside row spanning whole table, so you
wouldn't detect it.


All said, the fact that beta version of a browser doesn't render
gitweb correctly, while HTML is correct and follows examples in
HTML specification, is not a reason to change gitweb: it is reason
to file bug report, and try newer version.

If some popular browser had trouble rendering some complicated HTML
code, we could think of changing gitweb.

P.S. I have dug your original letter from spam folder on my GMail
account, and as far as I can see (reading via GMane NNTP / news
interface) it didn't appear on git mailing list either, probably
because of VGER antispam filter.

P.P.S. All that aside your commit message needs improvements.
First line (summary line) should IMHO start with "gitweb: ",
not "git_blame2", and tell _what_ was fixed.
-- 
Jakub Narebski
Poland
