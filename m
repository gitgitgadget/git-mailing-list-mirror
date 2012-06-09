From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCHv6 4/4] Write to $XDG_CONFIG_HOME/git/config file
Date: Fri, 8 Jun 2012 20:48:49 -0700
Message-ID: <CAJDDKr6sCrwy99-5-sOaAuNjYmnw73CicF3PyYMe8hvf38oFvg@mail.gmail.com>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	<1338988885-21933-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 09 05:48:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdCfY-0000YI-44
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 05:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab2FIDsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 23:48:51 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42127 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755642Ab2FIDsu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 23:48:50 -0400
Received: by yenm10 with SMTP id m10so1731228yen.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 20:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OX/vl8XdgsQhSUzW0GVRFVUEgFBupk2/l/0N0RpekSw=;
        b=RKIgMDeuTwTYTF8bRYR22EiNdmhidmS32GFrOrWiyIDgVzkdlc3+D1hQaSQ+fPQnnz
         JGUsItxT8BozITXgoIPCrZm1pd75FvQsTVwuo0LcM8bC9hS67/iwawME0/zsvTzu4yNz
         FpZWmvU0xKhp76PpWpJhE6d/AKWopUEuKiPDVPzwIJCwd5WjVGPTaw6te6jrOk0fb32C
         iwxqtakNHQSnUNa7mwSU6FDU5DFDPwPzlJy2kpHDA1gRzvzjIsYAqsTsehroL/lqhzWU
         8XYqrefQeN1BPUFxOgX6R4AfMo6z/N7YRRLFq6TMbVbVhIVH3083CVzADrO/ikoIrHj+
         zwGw==
Received: by 10.236.173.135 with SMTP id v7mr10504901yhl.19.1339213729781;
 Fri, 08 Jun 2012 20:48:49 -0700 (PDT)
Received: by 10.147.41.5 with HTTP; Fri, 8 Jun 2012 20:48:49 -0700 (PDT)
In-Reply-To: <1338988885-21933-4-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199543>

On Wed, Jun 6, 2012 at 6:21 AM, Huynh Khoi Nguyen NGUYEN
<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr> wrote:
> From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
>
> Git will be able to write to $XDG_CONFIG_HOME/git/config, a new
> configuration file following XDG specification, if:
> - this file already exists, and
> - $HOME/.gitconfig file doesn't, and
> - global option is used.
> Otherwise Git writes to $HOME/.gitconfig with global option, as usual=
=2E
> If you don't create $XDG_CONFIG_HOME/git/config, there is ABSOLUTELY
> NO change. Users can use this new file ONLY if they want.
> If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/con=
fig
> will be used.
> Advice for users who often come back to an old version of GIT:
> you shouldn't create this file.
>
> Signed-off-by: Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ens=
imag.imag.fr>
> Signed-off-by: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>
> Signed-off-by: Franck Jonas <Franck.Jonas@ensimag.imag.fr>
> Signed-off-by: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
> Signed-off-by: Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> ---

I'm all for this change too.

I did a little research RE: the OSX and Windows question.

glib makes no differentiation between OSX and Linux,
but Windows does have its own #ifdef.

http://git.gnome.org/browse/glib/tree/glib/gutils.c#n1251

I certainly don't think this should affect this series,
I'm just noting it as something that the Windows folks might
care about.  Perhaps something for compat/ in the future?

The downside to doing the same as glib is more documentation.
The upside is... consistency?

Thanks,
David


> =C2=A0Documentation/git-config.txt | =C2=A0 =C2=A03 ++-
> =C2=A0builtin/config.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A05 +----
> =C2=A0t/t1306-xdg-files.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 30 ++=
++++++++++++++++++++++++++++
> =C2=A03 files changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.=
txt
> index 7e344a2..a2b4786 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -97,7 +97,8 @@ OPTIONS
>
> =C2=A0--global::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0For writing options: write to global ~/.gi=
tconfig file rather than
> - =C2=A0 =C2=A0 =C2=A0 the repository .git/config.
> + =C2=A0 =C2=A0 =C2=A0 the repository .git/config, write to $XDG_CONF=
IG_HOME/git/config file
> + =C2=A0 =C2=A0 =C2=A0 if this file exists and ~/.gitconfig file does=
n't.
> =C2=A0+
> =C2=A0For reading options: read only from global ~/.gitconfig and fro=
m
> =C2=A0$XDG_CONFIG_HOME/git/config rather than from all available file=
s.
> diff --git a/builtin/config.c b/builtin/config.c
> index da54fd1..e8e1c0a 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -387,10 +387,7 @@ int cmd_config(int argc, const char **argv, cons=
t char *prefix)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0home_config_pa=
ths(&user_config, &xdg_config, "config");
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (access(user_co=
nfig, R_OK) && !access(xdg_config, R_OK) &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (act=
ions =3D=3D ACTION_LIST ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
actions =3D=3D ACTION_GET_COLOR ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
actions =3D=3D ACTION_GET_COLORBOOL))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (access(user_co=
nfig, R_OK) && !access(xdg_config, R_OK))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0given_config_file =3D xdg_config;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (user_=
config)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0given_config_file =3D user_config;
> diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
> index eb0f40b..dbf236a 100755
> --- a/t/t1306-xdg-files.sh
> +++ b/t/t1306-xdg-files.sh
> @@ -154,4 +154,34 @@ test_expect_success 'Checking attributes in a no=
n-XDG global attributes file' '
> =C2=A0'
>
>
> +test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\=
''t' '
> + =C2=A0 =C2=A0 =C2=A0 mkdir -p .config/git &&
> + =C2=A0 =C2=A0 =C2=A0 >.config/git/config &&
> + =C2=A0 =C2=A0 =C2=A0 rm .gitconfig &&
> + =C2=A0 =C2=A0 =C2=A0 git config --global user.name "write_config" &=
&
> + =C2=A0 =C2=A0 =C2=A0 echo "[user]" >expected &&
> + =C2=A0 =C2=A0 =C2=A0 echo " =C2=A0name =3D write_config" >>expected=
 &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected .config/git/config
> +'
> +
> +
> +test_expect_success 'write: xdg file exists and ~/.gitconfig exists'=
 '
> + =C2=A0 =C2=A0 =C2=A0 >.gitconfig &&
> + =C2=A0 =C2=A0 =C2=A0 git config --global user.name "write_gitconfig=
" &&
> + =C2=A0 =C2=A0 =C2=A0 echo "[user]" >expected &&
> + =C2=A0 =C2=A0 =C2=A0 echo " =C2=A0name =3D write_gitconfig" >>expec=
ted &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected .gitconfig
> +'
> +
> +
> +test_expect_success 'write: ~/.config/git/ exists and config file do=
esn'\''t' '
> + =C2=A0 =C2=A0 =C2=A0 rm .gitconfig &&
> + =C2=A0 =C2=A0 =C2=A0 rm .config/git/config &&
> + =C2=A0 =C2=A0 =C2=A0 git config --global user.name "write_gitconfig=
" &&
> + =C2=A0 =C2=A0 =C2=A0 echo "[user]" >expected &&
> + =C2=A0 =C2=A0 =C2=A0 echo " =C2=A0name =3D write_gitconfig" >>expec=
ted &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected .gitconfig
> +'
> +
> +
> =C2=A0test_done
> --
> 1.7.8
