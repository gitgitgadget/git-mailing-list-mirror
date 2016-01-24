From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/5] [WAS: Submodule Groups] Labels and
 submodule.autoInitialize
Date: Sun, 24 Jan 2016 20:38:00 +0100
Message-ID: <56A52818.8080808@web.de>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	gitster@pobox.com, jrnieder@gmail.com, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Sun Jan 24 20:38:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNQUs-0006uv-GZ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 20:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbcAXTiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 14:38:13 -0500
Received: from mout.web.de ([212.227.17.11]:53629 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbcAXTiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 14:38:11 -0500
Received: from [192.168.178.41] ([79.211.102.82]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lr2dj-1Zt3sN3sFn-00eauI; Sun, 24 Jan 2016 20:38:05
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <1453509103-16470-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:X1BD3vQ/zYMKlNXchXS4kojkV4TwkrABu+ZXthHQ82rnBaWKzvz
 yQ+fh3JZcOIDhx8UF5guuZhUy8nVs/Y6YMV1b5UtxeBtzlgjTQaEXlDiTjuHrHPmnTiyiz/
 RIkH4EdITy0K2YfcGnyhBNpDE7I/3f68O6EycEHUAe/dBCkKUxi9IGUdOnB3UBYAtoYs0Fs
 6+lJhjwnXnGjfhfzPgIfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7rlosheRL1w=:eUDR1cKHp8JOi7PcK8xrVp
 tajn1L6Z8MIXAYou0UjdIGmUpX/sxRpoae7V+w+yUOYrFtnW1CiYvfpqb9vsh+1JiaxOs5vKy
 xS5H52qCxvbGoCSe9ZcfiPLUYnxAwwIrW+1LvZbzwmuXPWHnXXYMGNV2w2pLWF8G0VUCZNoGG
 wduiQNkaOmYnrTTKkOeuqYP+tJ2VrkMVoAIiI+Khwz4l7aCpOpygy/b+S3mgtabDWNEdV1DnV
 KY6dOKHH7m154CFSvHJhapRLUMZsc72S9Jxz/yh11D9nUyD6vYFUDf3Pnjj/XQ4v9kCWmaC8S
 4+tvrAGWzPlgt+jC9bG8WOhxmgKX9qEAABHpPDulOpiXq/mBy288BKil/ytJ/XeMBFdRIx87Q
 Uiol99bJSJ/W1g1BYkoT0H3wMKVYiQN/3SJObmyi7aiJhSydwsRyaSU+X30eNRlPXw3ntfTxK
 UrYgcXZ73GROSuE6HfWbkYC5pVmRugGzE+AhnFlCjaG4EGgMpu6xANJUC+/1FhZcBpjiidiQN
 6+wL2tytuidbI/qOtIa/ucMESsAjaa8H69+kQDxF3gpEyzGJaSowP3AyS5VlGxrqqa55arhTC
 h+s99iKgG1SZF2NTEHO/RZyWkJ6iFFzT1JzRIxJ0zXk6hFJFHXxUJM7SPfegBivIUqTiIk4Jm
 YfRZ5eb8xcRPEsU+L0MwpR0Ivm2ZtiwCqPjIubdGY/M2AXhGFXVCMkWGnH/3+n+Mi4S+YFbuo
 GFgXFCdjQq4USymLlwT73SEWJMC+qPkUMTf3j7jtjl9W8ZWcoEjdykgMIuOWnAYbRVWxoQ7Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284690>

Disclaimer: Due to my currently very limited Git time budget I only
glanced over the recent discussion and patches. If you think I missed
something already discussed, I'd be happy being pointed to the relevant
discussion so I can catch up and avoid wasting everybody's time.

Am 23.01.2016 um 01:31 schrieb Stefan Beller:
> This series introduces labels which you can attach to submodules like so:
>
>      $ cat .gitmodules
>      [submodule "gcc"]
>          path = gcc
>          url = git://...
>          label = default
>          label = devel
>      [submodule "linux"]
>          path = linux
>          url = git://...
>          label = default
>
>      $ git submodule add --name emacs --label "editor" --label default git://...
>
>      # If upstream has submodules properly labeled, you can make use of them:

Cool. Without having looked at the code I assume you also can label
submodules yourself in .git/config (or your global config) to override
upstream's settings (or use your own labels if .gitmodules does not
contain any)?

>      $ git config --add submodule.autoInitialize "*default"
>      $ git config --add submodule.autoInitialize ":name"
>      $ git config --add submodule.autoInitialize "./by/path"

Ok. Though we might wanna call it submodule.autoUpdate, as initializing
it is only the prerequisite for automatically updating submodules. And
I believe automatically updating is the thing we're after here, right?

I'll try to explain why I believe we should be generous in initializing
submodules: If a submodule in one branch has a label configured to be
automatically updated and hasn't got the same label in another branch,
we still need to initialize the submodule even when we are on the latter
branch in case the user switches to the first branch, right? And the
fetch command needs to fetch submodule changes too when they happen in
a branch where this submodule is part of a label group configured to be
updated automatically, no matter what is currently found in the work
tree.

So I'd propose to:

*) Initialize every submodule present on clone or newly fetched when
    the autoUpdate config is set.

*) Automatically fetch only those submodules that are changed in
    a commit where they have a label configured (in the commit's
    .gitmodules or locally) that is to be checked out.

*) Let "git submodule update" update only those submodules that
    have an autoupdate label configured.

That will make switching between branches with different label
configurations work fine. Or am I missing something here?

And we need to teach diff and status to complain about empty work
trees and missing initialization of submodules that are to be
automatically updated too.

>      # The prefix * denotes a label as found in .gitmodules
>      # : goes before names
>      # path are prefixed ./ currently
>      # both path and names need work

Question: how do I configure all submodules to be automatically
initialized without having to give them a label? "./*"? Or just
setting the option without a specific value?

>      # no --init necessary, partially initializes submodules (only those which
>      # were specified by label, name or path)
>      $ git submodule update

Yup. Just like they will be fetched if they haven't been yet they
should be initialized if they haven't been yet but are configured
to be automatically updated.

>      # time passes, upstream may have added new submodules and we get them without
>      # extra commands!
>      $ git submodule update
>
>      # The above configuration can be given to git clone directly via:
>      $ git clone --init-submodule=*labelA ...

Ok. Expecially nice is the ability to also give names and paths to
"--init-submodule". (but maybe that option should be called
"--autoupdate-submodule" for the reasons stated above?)

> Why?
> ====
> If you have lots of submodules, you probably don't need all of them at once,
> but you have functional units. Some submodules are absolutely required,
> some are optional and only for very specific purposes.

I'd rather like to see this as a special case of sparse checkout, as
this will be a submodule-specific solution to a more generic problem.
But as I understand configuring sparse checkout won't materialize for
quite some time, so I suspect we'll have to add labels first to make
current submodule users happy in the near future. Sparse configuration
can then re-use the infrastructure added here.

> Changes to the previous version with groups:
> ====
> * it's called labels now (it's easier to imagine to attach more than one
>    label to a submodule than having it in more groups)
> * In .git/config we have another name, too ("submodule.autoInitialize")
> * Support for more than just groups, but also names and paths are supported
>    (in a very rudimentary way though)
>
> This series applies on top of sb/submodule-init, or can be found at
> https://github.com/stefanbeller/git/tree/submodule-groups-v3
>
>    Thanks,
>    Stefan
>
> Stefan Beller (5):
>    submodule init: Write submodule registration to stderr
>    git submodule: Teach add to label submodules
>    submodule-config: keep labels around
>    submodule update: respect submodule.autoInitialize
>    builtin/clone: Configure submodule.autoInitialize via --init-submodule
>
>   Documentation/git-clone.txt     |   6 ++
>   Documentation/git-submodule.txt |   5 +-
>   builtin/clone.c                 |  40 +++++++++-
>   builtin/submodule--helper.c     |  58 +++++++++++++-
>   git-submodule.sh                |  14 +++-
>   submodule-config.c              |  15 ++++
>   submodule-config.h              |   2 +
>   t/t7400-submodule-basic.sh      | 165 ++++++++++++++++++++++++++++++++++++++++
>   8 files changed, 298 insertions(+), 7 deletions(-)
>
