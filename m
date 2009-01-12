From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Lightweight tag ?
Date: Mon, 12 Jan 2009 14:56:49 +0100
Message-ID: <38b2ab8a0901120556x279f320oe693304dd2452050@mail.gmail.com>
References: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>
	 <7v63klsgf5.fsf@gitster.siamese.dyndns.org> <m2bpucnas2.fsf@gmail.com>
	 <496B3DA8.1040308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 14:59:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMNJh-0006en-OX
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 14:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929AbZALN4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 08:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbZALN4w
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 08:56:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:28408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbZALN4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 08:56:51 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3912217fgg.17
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 05:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aoXkConhIK9FgvjM9RNkXGxPhn4cmV4ppqXna1F/3Xw=;
        b=jWNiuBrTHPqxnnYMeIqKxANvMfefyHaPIvAqzUGZJKrSVtGk0EUsPBeldk6SaraER8
         ae11SHYwd4QCJQykM3SlsW4Moks3WxmEJegi6W/HTo1alG8fRvUeNcixRbhzN3929/ab
         dHEmqgArQdrLQYdOp5hFBpwJEK2mLU7BGt5GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gaCJ0DqiYlv8zDJaf2byM6xjF918aFpOJ3EYuF74qyXROeXXiSV1vfQA5ySiIqgVZi
         G/VLsWc8cgVDraKB4pPt7sJyarh4DiltxY7g/94JX6E3O/jp03Hycyxns6Idy8tuOOqB
         rvJ94BJqx1Fd3o84NjqciRClqZodA72fSkS94=
Received: by 10.86.53.8 with SMTP id b8mr16736951fga.58.1231768609469;
        Mon, 12 Jan 2009 05:56:49 -0800 (PST)
Received: by 10.86.29.14 with HTTP; Mon, 12 Jan 2009 05:56:49 -0800 (PST)
In-Reply-To: <496B3DA8.1040308@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105344>

On Mon, Jan 12, 2009 at 1:55 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Your test above confirms that the description is correct and nothing is
> missing. "git push" pushes explicitly listed refspecs (or : as a
> default). It pushes tags (light and heavy) when asked to.
>

So do you mean that the only way I have for pushing annoted tags only is
to do:

   $ git push origin refs/tags/annoted

That's not what Junio said:

   Don't use explicit --tags blindly.  It says "no matter what kind of tag,
   transfer everything under refs/tags".  Otherwise you won't see a
   difference.

So I interpret this like don't use --tags otherwise lightweight and annoted tags
are the same.

> "git pull" pulls tags if they can be reached from heads which are
> pulled. It pulls all tags only when asked to.
>

[...]

> So, "non-local" tags are the ones which can be reached from heads which
> you pull, and local ones are the others.

So I can't create a local tag on public heads (the ones I'm pushing
out), can I ?

> I don't think lightweight tags are more local than tag objects
> (please correct me if I'm wrong; I think this needs more doc)

Perhaps it needs documents which are more user friendly: I don't know where
the 'lightweight' word is coming from (perhaps from the implementation) but
I would expect that the _local_ term appears in the git-tag manual.

> It's just that the latter reside in the object db
> store whereas the former are simple refs under refs/tags.

That's implementation detail...

I just need to create a local tag where I'm sure it won't be seen by others
whatever the git operations I'm doing, normally a simple "git tag" switch
should be enough...

thanks.
-- 
Francis
