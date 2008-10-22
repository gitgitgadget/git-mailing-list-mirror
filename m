From: "Brett Ryan" <brett.ryan@gmail.com>
Subject: Re: Does a `git pull' write to the origin repository in any way?
Date: Thu, 23 Oct 2008 01:27:00 +1100
Message-ID: <a65d095e0810220727n66d83bcag15213ef3554ce834@mail.gmail.com>
References: <a65d095e0810220200q42936427o917cdac067d04135@mail.gmail.com>
	 <20081022132517.GM3988@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Marc Weber" <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 16:28:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsehF-0007kz-7p
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 16:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYJVO1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbYJVO1D
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 10:27:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:48510 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbYJVO1B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 10:27:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3043828wfd.4
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tp+s6CV24qCTTDKKv+ULMJ1Kgp9tNActPBZCm5eCFmw=;
        b=sEgrQtb6e/vuuISbIEhBd2fQ9Eb64YlRo6Vk352+vjXc6xcMKCG70ntx3cJolkOhbe
         SzHcZ2qLwFuV7ogvT1PeCnJFloGL3K3TGg2H9B6ZQfsJ1gf9NGIpVY57LOYHk5dRT8YI
         4MPQjoPxFjU5IwxHVCD8RF13U1cc9nf9vago8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KxCPf2NILd0gujP+KRqR6vZ967bNXTsGoC44mAvB6Jn+RejDL8vT8gJUN2UMUu2Ms2
         6QgImyABZLS4k+bYm8Guf6h5fUMSiMh3pphl3CwconMOx8RgJmGDhoPltGmUKqFEr/KS
         4svs+B9BCF+zLUcqMtdlvmkZ5DD8A9aoHjags=
Received: by 10.141.44.13 with SMTP id w13mr6529143rvj.13.1224685620578;
        Wed, 22 Oct 2008 07:27:00 -0700 (PDT)
Received: by 10.141.145.6 with HTTP; Wed, 22 Oct 2008 07:27:00 -0700 (PDT)
In-Reply-To: <20081022132517.GM3988@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98870>

Thanks Marc. I agree the dev cycle is a little strange, though we're
still using a 4GL environment (Progress) from the 70's where all the
developers have no prior experience to version control except for
renaming files to ${name}.yyyymmdd.

My apologies for being a little light headed I've only been using git
for about a week now, currently I'm the main merger for CVS and
looking for an alternative. First impressions of `git' to me are
fantastic and it seems to fit right, what I need to do is figure out a
good dev cycle that my peers can use as they're all used to working
int he same directory and just simply yelling out to each other "I'm
about to edit file {x}", making me cringe each time.

Anyway Marc your answer was all I'm after, it could have been
something I goofed, just needed clarification that a pull wasn't going
to touch the rep that the pull is pulling from.

Thanks,
-Brett


On Thu, Oct 23, 2008 at 12:25 AM, Marc Weber <marco-oweber@gmx.de> wrote:
> On Wed, Oct 22, 2008 at 08:00:11PM +1100, Brett Ryan wrote:
>> Greetings, the reason I ask this question is because my pattern of
>> development is to create local source git repositories on my home
>> directory, then pull them to the central location. I found myself
>> getting the error `unable to create temporary sha1 filename
>> .git/objects/11: File exists' which after investigation found that
>> there were paths in `.git/objects/' owned by root which is who I use
>> to do the pull from my home directory using sudo.
> Aeh.. about which repo are you talking here? I guess it's not the one
> owned by root because otherwise this would be normal..
>
> Hi Brett, I'm not sure where the problem comes form. But I feel your dev
> cycle is kind of wired.
> If you can login as root using ssh you can also do it the "normal" (?)
> way:
>
> # user dir
> git remote add root_repo ssh://root@localhost/path-to-root-repo
> git pull root_repo # then resolve conflicts if any
> git push root_repo # update the root repo
>
> This way you always have conflicts in your local repo and never on the
> root one which is preferable (IMHO)..
>
> git-fetch doesn't list a way to access another repo by "su(do)" which
> might be the best way here ? This could be convinient because you
> would'nt have to setup an extra group to access the same repo as root
> and user (?)
>
> You're right that git pull *should not* modify any files from the repo
> its pulling from.. But I don't know enough about git internals to say
> more about this. All I know is that git clone might have created some
> hardlinks.. But I'm not sure how this interfers with file permissions.
>
> I hope someone else can give a more accurate reply.
>
> Marc Weber
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
