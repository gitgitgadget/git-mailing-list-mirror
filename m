From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: [msysGit] [PATCH 10/12] Add ANSI control code emulation for the Windows console
Date: Wed, 2 Jul 2008 15:32:56 -0400
Message-ID: <eaa105840807021232r17ca03f4y1487a7659eb04da4@mail.gmail.com>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
	 <1214987532-23640-9-git-send-email-prohaska@zib.de>
	 <1214987532-23640-10-git-send-email-prohaska@zib.de>
	 <200807022117.38166.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: prohaska@zib.de, msysGit <msysgit@googlegroups.com>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Sixt" <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:34:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE85V-0008Ep-1r
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 21:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbYGBTc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 15:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbYGBTc7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 15:32:59 -0400
Received: from gv-out-0910.google.com ([216.239.58.188]:62780 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbYGBTc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 15:32:58 -0400
Received: by gv-out-0910.google.com with SMTP id e6so104899gvc.37
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=g2Gw7bIevoZizjooRbE2alJ0V95L+h64vNzV0pFXRYY=;
        b=JrWHXsZkD9zm4XE638geSXrPnOeZ/uGW5XaUTq1N92HgsG652r+kI774LT5P2LBm2Z
         NrFAoHnTw2DpGDD6zqv06dRreZAU7HngkGsTs11gXyt667RnmgaXaggWu6F3EDhOptA1
         QVYCa1xzNBG9oPBOqOqhpy1gI249sv39ON9VE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=U6ICqUDc+xxvHy9fP8+oPQL/VWx5OqozxHP+mu9g8KuMJx99LjHqNtFktdvtW/qFpl
         PN6GUlrTurT7KZufZR7Oq7xghLYMP/tR98NoSqaDMLPhWDWF4zvitbDAWwpd9xnTe1pZ
         77UdHGedi83H8Hb02zQ1GeEsXJSH7j/+MWBQs=
Received: by 10.125.153.16 with SMTP id f16mr1786176mko.178.1215027176747;
        Wed, 02 Jul 2008 12:32:56 -0700 (PDT)
Received: by 10.125.159.20 with HTTP; Wed, 2 Jul 2008 12:32:56 -0700 (PDT)
In-Reply-To: <200807022117.38166.johannes.sixt@telecom.at>
Content-Disposition: inline
X-Google-Sender-Auth: 7eada4a75ca9c133
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87185>

On Wed, Jul 2, 2008 at 3:17 PM, Johannes Sixt wrote:
> On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
>> This adds only the minimum necessary to keep git pull/merge's diffstat from
>> wrapping. Notably absent is support for the K (erase) operation, and
>> support for POSIX write.
>
> If I understand the patch correctly, it won't affect output that goes to the
> pager; only text that goes directly to the console would be colored.

Yes, that is correct.

Note that an MSYS bash/rxvt is effectively considered a pager by this
patch, since it fails the isatty() test. This is actually a good
thing: MSYS has better ANSI support anyway.

Peter Harris
