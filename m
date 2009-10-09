From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: Merging non-git releases of a project
Date: Fri, 9 Oct 2009 22:33:57 +0100
Message-ID: <26ae428a0910091433v2c959a70g9bfc6c54382f370d@mail.gmail.com>
References: <26ae428a0910091411i39a03650o51163f794b984524@mail.gmail.com>
	 <32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 23:46:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwNIB-0004vf-IF
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 23:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934492AbZJIVeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934490AbZJIVeg
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 17:34:36 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:34193 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934462AbZJIVee convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 17:34:34 -0400
Received: by ewy4 with SMTP id 4so1015983ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=hnIEfanh00ZlDbyZN/PygJvx3iH5aQEqv4xr58TDqqY=;
        b=CsZknSDROnABNWDw1KTiaV+2fzxQsEq3FgZWeJrNONcORMuHCclRvoWp/oItNU+jqe
         g3euTj4xpKZAiqumibmJnxbplwKxEC2AHlYNs225zADQq0hiC7J5QFUKbRymjyWDQmHL
         pS+ITBO1QHKEscEGkFk7+LNFaVqFHOZeoGtOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=OiTD89MZg8EffOtKmpB4+v8sQEiEvsrjqQeAPFlPpcx5ltrH4l8AcMLE8y7zkcDwhW
         xgJVkDYZckC+sqDI0q0DpCD12QxLAL1CVQnIbIqwlWhEHcnnLXO6NiHYZrzdPZV0kedc
         oT7ZOlT5ePzFUlWizM2Vzh8AwulcpUdtdIhd0=
Received: by 10.216.88.21 with SMTP id z21mr1067741wee.60.1255124037443; Fri, 
	09 Oct 2009 14:33:57 -0700 (PDT)
In-Reply-To: <32541b130910091427i7c8a2426hb69a9914aabde8bc@mail.gmail.com>
X-Google-Sender-Auth: 9613a4a2036d989e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129845>

Hi, Thanks!

I'm missing the point here though. Where/when  do I actually add the
new pristine code? If I checkout, as you suggest, my initial commit I
just have (say) v1.0 of the vendor's code. I can't just copy (say)
version 1.2 on top as the files probably won't match one-one.

Sorry - I'm probably completely failing to understand.

2009/10/9 Avery Pennarun <apenwarr@gmail.com>:
> On Fri, Oct 9, 2009 at 5:11 PM, Howard Miller
> <howard@e-learndesign.co.uk> wrote:
>> Here's my dilemma.... I've used git extensively to track modificatio=
ns
>> made to a reasonably large source tree. I do not have access to the
>> repository for that project, just a given release. I have now acquir=
ed
>> the latest version of that project and I want to 'merge' (not sure
>> that's the right word in this case) my changes into the new version.
>> Then I need to carry on using git for further changes. I think it
>> should be simple but I can't get my head around the best way to do
>> this.
>
> Find out the commitid of the first commit when you checked in the
> upstream project into git, and call it C1.
>
> =A0git checkout -b vendor C1
>
> (replacing C1 with the commitid). =A0This creates a branch called
> 'vendor' which is for checking in *only* the pristine code provided b=
y
> the vendor. =A0It also checks out this new branch.
>
> Next, import the new upstream version of the project and commit it to
> the 'vendor' branch.
>
> Now, switch back to your branch and merge in the vendor changes:
>
> =A0git checkout master
> =A0git merge vendor
>
> Or, if you want to produce a clean set of patches on top of the vendo=
r
> version (ie. for submitting the individual patches upstream), you
> might want something like this instead:
>
> =A0git rebase vendor
>
> But be careful, rebasing can make a mess of your history and you
> shouldn't do it unless you have a good reason.
>
> Good luck.
>
> Avery
>
