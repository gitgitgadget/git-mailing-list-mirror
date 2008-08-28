From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Thu, 28 Aug 2008 08:26:31 +0200
Message-ID: <cb7bb73a0808272326s77391a10v607043f82f9b581f@mail.gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200808261015.37023.jnareb@gmail.com>
	 <cb7bb73a0808260358o41a04a9ara701e6c726cf2298@mail.gmail.com>
	 <200808261349.28771.jnareb@gmail.com> <48B602B5.1070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@ucw.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Lea Wiemann" <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 08:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYazp-0000HL-RG
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 08:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYH1G0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 02:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbYH1G0d
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 02:26:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:30668 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbYH1G0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 02:26:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so134353yxm.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 23:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/uZbc7HlTUtRkS67TwPVTEVJbHHCryfYq+CNfqHGyZs=;
        b=D1DzXshNXx/GzPV0kzwQUwfgtV73JRTeBE0kvTV4pDnTJPWoZLauHNe9J9UoRDTutl
         EBh7KO0kXsPjWvkgcPEmXkJqtVDJPVZA79fuvss7IwVCXLdZgAZNxINSxlw0NcAV14Na
         YMACYvHWAVZX4JDLycjTFw3wCHMkkfAXg5XkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ei/HRwU44Pt0psI6+WtOXXT5PlTZ6cSUKOgiSJz3liU0P1VHakne2noyev1KwugbYs
         ciKOhNCPDHeoQs2o0OGoJzsUujgrlC72fmfHFUo3qLI8zECdYAVwuKQBnPUX4jTFVN5T
         6z9GZ6UrW8c88EyhX6F9l16Ms2vPKMqkUYqV8=
Received: by 10.151.158.2 with SMTP id k2mr1559002ybo.125.1219904791346;
        Wed, 27 Aug 2008 23:26:31 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Wed, 27 Aug 2008 23:26:31 -0700 (PDT)
In-Reply-To: <48B602B5.1070304@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 28, 2008 at 3:43 AM, Lea Wiemann <lewiemann@gmail.com> wrote:
> Jakub Narebski wrote:
>> By the way, this is argument *for* selecting action when generating
>> link, if it is possible without incurring unnecessary (if you don't
>> follow the link) performance penalty.
>
> I agree that it's much cleaner to select the action when generating the
> page, rather than having an 'objectview' action or so.

In that case v7 of my patch is The Way (TM).

> Worrying about performance seems like premature optimization though --
> my guesstimate is that the performance penalty for looking up the object
> type is not practically noticeable (read: relevant), and with my patch
> applied (even without caching activated) it should move below the
> measurable range.  So don't complicate the code to gain another 0.01%
> performance. ;-)

Well, considering that after Jakub's suggestion we just get the target
type from the presence and absence of ^{} in the output of show-refs,
we're not making the code overly complex :)

BTW, any ETA on your caching changes landing in git? I'm really
curious to see how many of my changes are not compatible with it 8-D

-- 
Giuseppe "Oblomov" Bilotta
