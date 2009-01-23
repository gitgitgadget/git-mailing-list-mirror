From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [RFC/PATCH v3 2/3] sha1_file: prepare for adding alternates on 
	demand
Date: Fri, 23 Jan 2009 19:35:27 +0100
Message-ID: <8c5c35580901231035j31484249nf96e0e659b119a2b@mail.gmail.com>
References: <1232659071-14401-1-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-2-git-send-email-hjemli@gmail.com>
	 <1232659071-14401-3-git-send-email-hjemli@gmail.com>
	 <alpine.DEB.1.00.0901230041500.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQQtg-0006MV-U5
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 19:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbZAWSfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 13:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756991AbZAWSf3
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 13:35:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:60894 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850AbZAWSf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 13:35:28 -0500
Received: by wa-out-1112.google.com with SMTP id v33so15966wah.21
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 10:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SM65K/B+/cJghxTO59LO5d3DixvOxxrtZ6puxnb8lD0=;
        b=ps8nXtv82CL6nxXFLEqLCRICU6VnO+2707L4ykocEU0zBRwe9Gvt8Nq2kx6XmLBxJG
         fsGy0Lzsj5UGgFZxCNDUFDVz2RYzqVXMSgtxCc5kGQOUr/89lyk1yw6eBBR3tH7oD95g
         QlHcCLRkSej75EY7reTghUm8wHagy0LFVm81M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SgYAVvXDixOeO7YUMLWNyWf/i1a+URKF+3aHEk03EuunkQuZILKTpEZjwc6XcIl9mj
         4ROReRhv1RI8HD/YeEq77049Q2EBdW7ENJFqyRwEKjFSTWc+62oU0WaNxGPfVgkiE1Xz
         XRqX0yziNDHpc7V0fsp2rr04KRSudPuoIQubo=
Received: by 10.114.194.1 with SMTP id r1mr4208373waf.149.1232735727993; Fri, 
	23 Jan 2009 10:35:27 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901230041500.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106899>

On Fri, Jan 23, 2009 at 00:43, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 22 Jan 2009, Lars Hjemli wrote:
>> +             if (!quiet)
>> +                     error("object directory %s does not exist; "
>> +                           "check .git/objects/info/alternates.",
>> +                           ent->base);
>
> FWIW my concern is not at all addressed.  A future user of add_alt_odb()
> (and possibly your users in rare cases, too) can trigger the error that
> suggests looking into the alternates.  Leaving the human user puzzled.

Is it the phrasing of the error message that concerns you (when
invoked from add_alt_odb())?

If so, would something like this be ok/better?

>> +             if (!quiet)
>> +                     error("Alternate object directory %s does not exist ",
>> +                           ent->base);

--
larsh
