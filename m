From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: th/remote-usage
Date: Wed, 18 Nov 2009 16:28:33 -0500
Message-ID: <32c343770911181328v6d61967bna165f08b9e58d5be@mail.gmail.com>
References: <7v7hto46ce.fsf@alter.siamese.dyndns.org>
	 <20091118114808.GA13346@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 22:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAs5U-0008Ra-KL
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 22:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299AbZKRV23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Nov 2009 16:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757288AbZKRV23
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 16:28:29 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:61689 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068AbZKRV22 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2009 16:28:28 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so1687803fxm.21
        for <git@vger.kernel.org>; Wed, 18 Nov 2009 13:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HgCiQGT/0EQAjn7VsyDFssjCgNQWAwZu+olomhX3cD8=;
        b=b6h0bzoyIXTTmy/K6WCGH+Fd7koFyHRsMVASHOplmOzRq5lbG8IqMVA4u0rQXns1JQ
         2R4167lmef2mtM3P3aTppi+vSzOEbDvkMqAnAD83s2fw3upPJ7Za9fOzBPLCQ6IMWSpW
         mAWDRVeKCkdsQN2X8mxLJhpkpULve4qIi0h/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hG184q9qy/M1czeTZc2MSX+ld7JRkJSA2GJzqlmydEc9MbjdJOeSaM+nDEak4RN9uQ
         99+yqt5wSMeRn/JPcVKLEYlu4n8469pPYFhs5vukE/skdJcm07f8Ll3ilfh5if31oSKP
         65BgB5OwbGixouoy8E5aVHIUBjXcPowrTrATA=
Received: by 10.216.90.13 with SMTP id d13mr790868wef.130.1258579714133; Wed, 
	18 Nov 2009 13:28:34 -0800 (PST)
In-Reply-To: <20091118114808.GA13346@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133200>

Hi and thanks for your review.

On Wed, Nov 18, 2009 at 6:48 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Junio C Hamano wrote:
>> [New Topics]
>>
>> * th/remote-usage (2009-11-16) 1 commit.
>> =C2=A0- git remote: Separate usage strings for subcommands
>
> Glancing at pu^2, I had two small nitpicks: [<options>...] is five
> characters longer than strictly necessary

I based my patch on what I found in other builtin functions (such
as push and diff).  That being said, I don't think that either my
original patch or your updated version is completely correct.
The choices seem to be:
  (1) [<options>...]:  My original based on my interpretation of
      IEEE 1003.1. [1]
  (2) [options]: Your proposal, which drops both the '<>' and '...'.
  (3) <options>:  Used in builtin-diff.c.  Which does not show
      that the options are -- optional.
  (4) [<options>]: What I now believe is correct (based on the
      current implementation of builtin-push.c).  This drops the
      '...' which IEEE 1003.1 defines as allowing multiple options
      to be specified, but it conforms to the conventions in other
      commands.

There does not (yet) seem to be consistency in how options
are presented.  My current plan is to change the patch to
use choice #4, but if Junio has a chance to comment, I will
of course defer to his decision.

I will send an updated patch that implements choice #4 as
soon as I can (should be within the next 12 hours).


> and the argument to git
> remote set-head is not actually optional.

This was obviously an oversight on my part.  I will include the
fix in the next version.


=2E..and from your second email:
> Another option would be to make the strings into static
> variables.

Thanks for the analysis, but I don't plan to include this change
unless specifically requested.


[1]: http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.=
html
