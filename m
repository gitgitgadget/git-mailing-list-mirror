From: Stefan Beller <sbeller@google.com>
Subject: Re: Best practice setup for github projects on server
Date: Mon, 23 Nov 2015 13:32:21 -0800
Message-ID: <CAGZ79kar2BbLV6xnOz9HH+b-03Xu=EOagH1q3dsdLRFJxzS51Q@mail.gmail.com>
References: <8A5E5D5720EB7347BF290277F0C633F8010C7E55DFB4@MKT-MBX01.university.ds.derby.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthew Leach <M.Leach@derby.ac.uk>
X-From: git-owner@vger.kernel.org Mon Nov 23 22:32:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0yit-0000M9-GJ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 22:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbbKWVc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 16:32:26 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34270 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbbKWVcW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 16:32:22 -0500
Received: by ykfs79 with SMTP id s79so255089612ykf.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 13:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2SpjuF477GvyhuNxEDJiJOOGT1B9wJ0CGh5/oLMXf40=;
        b=Qs2bOwpXBAAeCBYvB03p232MglELMR5XV0oTzBqZxQnnFq8ktr6wJt6UrkzWbabQF0
         zY3d9QjO4V8MdFU4PU1nul6/OMI+XvVCf8f9bsyaCPFa5Mh4NGDM/Qwk3q+zcNGCyL/c
         mksryVQgmwf3w0osxM2fujMd201/xYf2acDH5gvTrMDE5pH6SfAKZk2hGAW4HB2ogxch
         +ji6fkaSyGGX421hRMmitMjVfFLh8c//mHG9C/YqNGf5Jq/KKmc5ewYqqCN01Biz2qgd
         20gdLcrm9Yr+BTAg8aS2GyY5LUHypFugQjt24JFC8RgPJ33eKpklUPGLoox0Ts/azGoM
         NnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2SpjuF477GvyhuNxEDJiJOOGT1B9wJ0CGh5/oLMXf40=;
        b=N2oVFAytyqaMr2fCjfxPaTLf2T00/XKN9oDjeKxRKxWdWOuEt6v/5CWIHGohoxAZxS
         g+5uzgM/N7W+Wb0Wvqx6jNpW2O3xTO2LULRaHcyfo6I45433KWh6JoNQZT9sBylvkwl3
         I61+s5mmHrkqGBjwJI7S5kjk7Xv1PwDaNRh748giHhgegaLMsWiaaWyCHBoBb3oDOxfA
         ktCHFL84JVQiCytDwSQMVlU4o0RtmvaQu5kM5DsJjUEi8faZDfL4B393EB/OoeUKcqwG
         EBsJv2QpV+IQS+4w0AEmRuVTW0nstaEKBVweJ7IShrGeksBRIz/kubIGQkn0/rxzZ4Kw
         BiTA==
X-Gm-Message-State: ALoCoQkJf9u7mgxksgMw07fyIqf3kjpsIE8K7od2DmmFktZNU7YsrHkJgqNAy6ccIqXyoWlYZLvN
X-Received: by 10.13.235.135 with SMTP id u129mr28165181ywe.48.1448314342025;
 Mon, 23 Nov 2015 13:32:22 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 23 Nov 2015 13:32:21 -0800 (PST)
In-Reply-To: <8A5E5D5720EB7347BF290277F0C633F8010C7E55DFB4@MKT-MBX01.university.ds.derby.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281599>

On Mon, Nov 23, 2015 at 3:19 AM, Matthew Leach <M.Leach@derby.ac.uk> wrote:
> Hi,
>
> I was hoping that somebody could give me advice since I'm new to git.
>
> I'll be installing a couple of projects from github on our servers, and adding some features.

So you take source code from github and improve it...

>
> Should I create a repository on our server (e.g. in /opt/git/), add the github project as a remote, and create a branch?

You can certainly do that. Why would you want to keep it on your
server though? (Is it not worth to be open because it's highly company
specific stuff? Is it closed intentionally because it would reveal
core company secrets? Is it just for backup, because you don't trust
githubs uptime?) Having 2 remotes (github and your server) makes the
workflow slightly more complicated, but if you don't mind a
complicated workflow that's no problem. But be sure to know why/what
benefits you gain from that. You could also go with your github fork,
which could be set to private, I'd guess.

> Then on my local machine add our server as the remote and then pull / push with that?

Sure, sounds fine.

>
> On the server there will be two web directories: stable and dev.  I was planning for these to be branches, and then just pull from the server repository using the local protocol.

Beware of that. There are quite a lot of servers serving the contents
of the .git directory, you may or may not want to expose the history.
(Certainly it looks odd)
For a private server I'd have the git directory somewhere non-public
(outside of /var/www, so maybe in the home directory of the git user)
and then a hook like this:

    $cat .git/hooks/post-update
    GIT_WORK_TREE=/var/www/your-stable-web-dir git checkout stable-branch
    GIT_WORK_TREE=/var/www/your-dev-web-dir git checkout dev-branch

That's one way to do it. And outdated by now (as I just wrote down the
config I have in a personal server).
Git has learned a push-to-deploy[1], which should do what you want there, too.

[1] https://github.com/blog/1994-git-2-4-atomic-pushes-push-to-deploy-and-more


>
> I think it would mean sorting out merge actions on the server.  I'm hoping to be able to fetch and integrate updates from the developer's github repository, but without making things more complicated than they need to be.
>
> Does anyone have any suggestions?  I drew a diagram if it helps (https://drive.google.com/file/d/0B7JhUXLbxPT9RkVNMUV6cjJNVnc/view?usp=sharing)

As said above, what exactly do you solve by having yet another line in
the diagram (with /opt/git/proj.git) ?
You can directly pull from github to the local developers workspace
(and sort out merge conflicts there)
and then push to deploy from the workspace, too.

If you need a place to share for just the subset of people in your
company, you could use the /opt/git/proj.git for sure, but you'd
pull&resolve merge conflicts to your workstation and then push for
sharing to your server.
(Also think about external hosting solutions, if they make sense there)

If you dislike the push-to-deploy approach (not everybody should be
able to push a new version, only a subset of people should be able to,
that should also work the same way as you would restrict the "pull
dev" and "pull stable", I'd guess)
