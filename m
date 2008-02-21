From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-send-email getting filtered as spam by vger.kernel.org
Date: Thu, 21 Feb 2008 16:41:08 -0500
Message-ID: <76718490802211341o1ddc36bbne4e6d551712e7cd0@mail.gmail.com>
References: <200802210429.58353.lenb@kernel.org>
	 <200802210721.29188.lenb@kernel.org>
	 <20080221205104.GA14247@informatik.uni-freiburg.de>
	 <7vejb6t3kk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=" 
	<ukleinek@informatik.uni-freiburg.de>,
	"Len Brown" <lenb@kernel.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 22:41:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJAq-0008BI-33
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231AbYBUVlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 16:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbYBUVlL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:41:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:56211 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbYBUVlK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 16:41:10 -0500
Received: by wr-out-0506.google.com with SMTP id c48so292073wra.23
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 13:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tCttEi+sPGZX+e7PQgdh+Cz6EO2WnA1aL9p4tXM8avU=;
        b=Mzl4GwK3TjqriWsQbh7Ae59c11AJiSs6CAgtdQY1C7CB4D65rrS0JNgleBZd3lT1fVW61Hz8WSw3mpsSmHMjgTN9HSLC+x4fNgVKyzNpYTXxUSrItMSzHA3o2ZcS1oCjRXolvFQaHVnL2vLexyeLYUbZy58n5Dwy/+ohIQVT0pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q2tmPNWwPiD6H9kuDLPcug2HI9eJ7qNggQczQELuNfANAnfGoe9RpkkXfk25qHZst/kq6Ihn0Wi8lL9reuTZQqfjgD2Ft3T19OaiYDO/It8qGQIeTTG+hwpr3fgtcFLtndVZdcdfFd562uas4NDTJB1qtnXAEPE37tyu61W6TD8=
Received: by 10.114.81.1 with SMTP id e1mr1642014wab.11.1203630068381;
        Thu, 21 Feb 2008 13:41:08 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Thu, 21 Feb 2008 13:41:08 -0800 (PST)
In-Reply-To: <7vejb6t3kk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74663>

On Thu, Feb 21, 2008 at 4:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Perhaps we should fix it up like this...

Doh, my bad...

>  diff --git a/git-send-email.perl b/git-send-email.perl
>  index ccb87a2..c9f8c6b 100755
>  --- a/git-send-email.perl
>  +++ b/git-send-email.perl
>  @@ -475,7 +475,7 @@ if ($thread && !defined $initial_reply_to && $prompting) {
>
>         $initial_reply_to = $_;
>   }
>  -if (defined $initial_reply_to) {
>  +if (defined $initial_reply_to && $initial_reply_to ne '') {
>         $initial_reply_to =~ s/^\s*<?/</;
>         $initial_reply_to =~ s/>?\s*$/>/;
>   }

Actually:

if ($initial_reply_to) { ...

should be all that's needed.

j.
