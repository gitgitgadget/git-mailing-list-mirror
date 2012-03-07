From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 18:23:34 -0800
Message-ID: <7vpqcpp2s9.fsf@alter.siamese.dyndns.org>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
 <4F567DC6.4070903@gmail.com> <4F567FEF.5000105@gmail.com>
 <CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>
 <CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>
 <CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>
 <4F569EA8.4050907@gmail.com>
 <CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Jerome Yanga <jerome.yanga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 03:23:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S56XX-0001SU-Lm
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 03:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab2CGCXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 21:23:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab2CGCXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 21:23:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 982627C59;
	Tue,  6 Mar 2012 21:23:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DzjIUXLaMtJJLaztdKb3tdOQNE=; b=dT28Cm
	GDxmAsnZBwySHxXqjMsg3PaqPiQyxS5RIXRKInIKZEXK8l06hdO8FSgnzKEgerk8
	Swcqr1SZD7m7/GR9zMWAczH3uiglX/Oz03kqAqyfwb9heeJWxtLgoS8ZXMU1Irbi
	bojgygRcdWG/zuBUkokS1D+IeAx2MwjeHrLvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayf1pNFfWPqu4Fe13x2vv+9eQvEp8wTF
	SJ8mTOFQcLtYvhoLUeckMuelC+DENDrCG9ZxlBCVBT0rS5JRuYS3I/yOSS2ElIFQ
	2qMY89Ig26qT2xVHoT93ahVRcsXRaGgYq0u640ySFmOt2c5WDG7pkQaNRfXW1aAW
	rh/cJF+h+2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E73A7C58;
	Tue,  6 Mar 2012 21:23:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F59F7C57; Tue,  6 Mar 2012
 21:23:35 -0500 (EST)
In-Reply-To: <CAC0z1F9sBYCuv_HMCx1ryWLvxZKUcLPS1UUj80ihEesje+SKzg@mail.gmail.com> (Jerome
 Yanga's message of "Tue, 6 Mar 2012 16:28:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B1661F6-67FC-11E1-BBE1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192421>

Jerome Yanga <jerome.yanga@gmail.com> writes:

> The project in Apache's DocumentRoot was created using the following command:
>
> "cd /var/www/git
> git clone --bare <non-bare working directory> <project>.git"
>
> Hence, I believe that is is bare.  Besides, it does not have .git
> folder.  I assumed that when I did this that the non-bare directory
> will also be updated when a push is performed via http.
>
> My objective is that I would like the developers to be able to push
> via http and these pushes will need to be reflected on the non-bare
> working directory as these directories will be used for automated
> tests.

So that <non-bare working directory> above is what you want to be
updated when you update <project>.git?

More concretely, for example, you have say /srv/project/frotz and
/var/www/git/frotz.git directories on that server.  Perhaps the
project may have started in the former:

	mkdir -p /srv/project/frotz
        cd /srv/project/frotz
        git init
        ... populate with the sources ...
        git add ...
        git commit

and then cloned to the other one

	cd /var/www/git && git clone --bare /srv/project/frotz frotz.git

I'll assume that is more or less the set-up you have.

Now, it depends on how the push goes to the latter one (I do not
remember offhand if pushing over dumb http transport triggers
hooks), but in general, you would install a post-update hook (read
githooks manual page) in the latter repository, that gets triggered
when it receives a push.  The hook could do something like this:

	#!/bin/sh
        unset GIT_DIR
        cd /srv/project/frotz &&
        git pull --ff-only /var/www/git/frotz.git master &&
	: you can trigger automated test here if you want to &&
        make test

The above example goes to the repository with a working tree, pulls
the latest change from the repository the user pushed into, and then
runs the automated test.
