Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE02E3364
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742096759; cv=none; b=bmo3Fh3zJNC9O3oF9tgN9Fvz8DYog2wk88C9ArkR9JtmKP21R4rbsHsa0pIqRnmrFRP9mxoHX9NG7x5F6H0+7w4MD7p2MlqfZ19hFiA9EsdeJML1g6OsINXB1Sobj7UUGGSjlyvnXVz9uC6WStIUvQCSR970rJOuYNOQQj8Fe2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742096759; c=relaxed/simple;
	bh=SlQg+MpX1wu2Od4UC5AEWvMizMhdRR1160z+2US4plk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kRty5sHJH60FJ+UbZ4clgmy77vCSVneVh0H7Y7rpEP4k/ot9vDQk/g1sCG+zWrC1hp9KqUL4nTBreBwzJGXmg5+9Yga9G2/jRZEZ25dR594+A1qu8C0vdT1rpXrxB2OGP4iAd68B3Iw8fKW9l6rnK15Hj0pq+OrUjHzlL98n/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=cs46qjof; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="cs46qjof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742096754; x=1742701554;
	i=johannes.schindelin@gmx.de;
	bh=H8N/0yIKflbQ39WE+WDYXadO8ExRGW13BHQC6tgX5+M=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cs46qjof4lIaPO9mUG/h+CmV3RqEUvqA88J8Ir8/YL16kYEy7RVbYyy8uKbmQDD1
	 0/L5u64X3MvGfPzi8QosnUQqRdgUFO3sIprVHD/qWDACQa7riEFjDzzw3gt0MIzqz
	 Fr8AVegQaekk4XJ8T+3zTHvPURLvDmq3BRSmh0afYsF64Ilztdcl4Y/7PwytRhr/a
	 IBrSlZSiIH19wQwrSTuBvKip3dcK62zViMKx+cw2BjkT87Pzv/LkZME2FDt2O6pUn
	 Gst4equPer87UIqbf/slCT2oQcYmec3Fr2u3mvVdJEarPMqzWCTNQY9gTYRrHheg4
	 FXAg3mSUpfVodVFemg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.73]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1poA-1tvqo63Jmq-005JGx; Sun, 16
 Mar 2025 04:45:54 +0100
Date: Sun, 16 Mar 2025 04:45:54 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tal Kelrich <hasturkun@gmail.com>
cc: gitgitgadget@gmail.com, git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3] gitk: new option to hide prefetch refs
In-Reply-To: <20240305194559.2373-1-hasturkun@gmail.com>
Message-ID: <993848e3-1138-0e69-c36c-acaa5ddce3a4@gmx.de>
References: <pull.1023.git.1629807526939.gitgitgadget@gmail.com> <20240305194559.2373-1-hasturkun@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pqRkoGgtHiTWeYfVMg7/csnCGJRU4H+fWI/hE6sYcsAgQPRjngF
 ioOHzFbO+DmqfW1Ni2c/nPOmvEXJ0hJGtR0MUBE3sYtJxwBi8gF7fncaBvk191FbrTBfOd0
 aV2lQ+fqGpVrgI6fOIsziY4WI9foqk2ma31POmd6vn30FrWLvPtohNiJZeSuprSJ6mRFLRh
 Bgi6c6SzD0Ww6gZMPVNvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PN4/TNho9r8=;z10bDWBx2x3zt5HJmVKhl9Q3cy7
 q9FJVXawahcLbxrK5MtA7ucb/5/MO7a8MJUlLJWjZCQTGe/Ew6RvQs7mMs5/GMvSRjd2Gwi4n
 Qf83ZhyDIm/DxmhMXp44AmttoTOoI6rIf6org0geS4j/Gps0ANWDb9/KGdN/JchzPg9JifBoB
 NSB3gFVszfV0ByB5EFkCATGdVsW4/CBPWa3ALj6zyFTMUxR/u7R4W/qzxwzpgkPobWca2HazS
 gPOjAgtF2Xk3Hq5M7x9iMteLYsx7Ax/OwX6ILIVnqukT/rsWUAsRHcva0W2qYvz3RibeGV3I6
 ja+SvKvRY26vgQ8lH8e3BUSmQAH/FPmqJA34k4usQP2a64HUV29kvofLiprtrRq5eWOhbxLg4
 00V53hx17IqXHFJBh66tz/8RTQiDaVY3kOAFIrnw3s/j47OzqFHsfQe1E5rdknvI2I2kJRRro
 EOAwgDK310DOuXfW1KMdv5HHzFKIc2s4wszv0ixGycb87Clr++7usulbj+KFvLHsjtbBZ7q+7
 fdGw471Pf3Jwk4MLDpnx5vFwMTTcv7Om/mbN87Q7mXar1/xppJFo4A2fvGPbbpwgG6XLL2zcd
 W11u3XXn9x+uTbS39uWWCX9tvgQI0wo1jDku626ePcOe9LRKX7CY6+XWqGTdabX+9OR6x5+gt
 DmIoJQtvia8Rb32In4GnqaxcPpxCmNWzzigZlunbIoiqIpJRjXpVZbqGUHnj6ds6Y/VeYpJQg
 kotv/OzsWyteVJd6VUizldGkYeXVPKtpzP1Xf4fO/O9nrAgnOBQmeqmbGUkFW/jZOH3CHxfvD
 Opz56+RQ5GfMJ3oT5+g2V0FAm6w9VXbmbACb9zHEjh0+p4M7R7c2WfyLPm0N/z1wa0aM9Q7kd
 T8hnY4q/c6CkdOiCtZFHHAMya/J6XkbJU3VHCB0jbWEbezioPfX0R+mCZ64zV6Hf+c+BpTIUy
 cQAQl4bOqa2nu1QYLDtPtQZQBe2Nuha+pw6gwnRi+OvTvEJK7P5YmTpn4g/Z9F4m1rxzECIGK
 E6ZNxr8797C5cqW0sgLyenrFCvO8K0sKf3apV2TpEMvdZMXPFnT3OveGZyD2BEzx5qfVvNqdD
 6hS3g9Wj4hY/+x736hLG2Az6rs7qgC9iR07iWiZmVKzdspbRBHgW+I6o5SHNrakDlGkTzYGyq
 HuYKInN3uAMZ5E2zJQFJC7hOrWt4GQDUkn/+nsDrtDAhh5tsrmIwZKPTiYyj7BqkmayJUozmV
 JiWKv06XjlGjokVRht7Iw/XAKWXLanvc5kcrRfW+J0e03B/jiNtTbklFVWyf/RpSmHKRtz4Ke
 TcHnygIvvHhYwxmBlWWkcCUO+Dgb0/Upj2SGZAUogBOPNV0Qhj9AZQRNTijNVUFNeC69ZblHr
 PSWIHManM6+nmcTfZARsbi6ftCvMHf1LCQRBwLSZRnWP/oYbpmM/mMsgZInqg5inVXmwA8je5
 1X0QpmZfxlV5tuByBE1GDJyL/LODIHi6whIhJw7FrMgeQjHhi
Content-Transfer-Encoding: quoted-printable

Hi Tal,

I'm Cc:ing the new gitk maintainer, for visibility.

Ciao,
Johannes

On Tue, 5 Mar 2024, Tal Kelrich wrote:

> The maintenance 'prefetch' task creates refs that mirror remote refs,
> and in repositories with many branches this can clutter the commit list.
>
> Add a new option to ignore any prefetch refs, enabled by default.
>
> Signed-off-by: Tal Kelrich <hasturkun@gmail.com>
> ---
> Changes since v1:
>  - Patch rebuilt on gitk tree.
>  gitk | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/gitk b/gitk
> index 0ae7d68..85315df 100755
> --- a/gitk
> +++ b/gitk
> @@ -1780,6 +1780,7 @@ proc readrefs {} {
>      global selecthead selectheadid
>      global hideremotes
>      global tclencoding
> +    global hideprefetch
>
>      foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
>          unset -nocomplain $v
> @@ -1814,6 +1815,7 @@ proc readrefs {} {
>              }
>              set tagids($name) $id
>              lappend idtags($id) $name
> +        } elseif {[string match "prefetch/*" $name] && $hideprefetch} {
>          } else {
>              set otherrefids($name) $id
>              lappend idotherrefs($id) $name
> @@ -11551,7 +11553,7 @@ proc create_prefs_page {w} {
>  proc prefspage_general {notebook} {
>      global NS maxwidth maxgraphpct showneartags showlocalchanges
>      global tabstop limitdiffs autoselect autosellen extdifftool perfile=
_attrs
> -    global hideremotes want_ttk have_ttk maxrefs web_browser
> +    global hideremotes want_ttk have_ttk maxrefs web_browser hideprefet=
ch
>
>      set page [create_prefs_page $notebook.general]
>
> @@ -11575,6 +11577,9 @@ proc prefspage_general {notebook} {
>      ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] =
\
>          -variable hideremotes
>      grid x $page.hideremotes -sticky w
> +    ${NS}::checkbutton $page.hideprefetch -text [mc "Hide prefetch refs=
"] \
> +        -variable hideprefetch
> +    grid x $page.hideprefetch -sticky w
>
>      ${NS}::label $page.ddisp -text [mc "Diff display options"]
>      grid $page.ddisp - -sticky w -pady 10
> @@ -11699,7 +11704,7 @@ proc doprefs {} {
>      global oldprefs prefstop showneartags showlocalchanges
>      global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markb=
gcolor
>      global tabstop limitdiffs autoselect autosellen extdifftool perfile=
_attrs
> -    global hideremotes want_ttk have_ttk
> +    global hideremotes want_ttk have_ttk hideprefetch
>
>      set top .gitkprefs
>      set prefstop $top
> @@ -11708,7 +11713,8 @@ proc doprefs {} {
>          return
>      }
>      foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
> -                   limitdiffs tabstop perfile_attrs hideremotes want_tt=
k} {
> +                   limitdiffs tabstop perfile_attrs hideremotes want_tt=
k \
> +                   hideprefetch} {
>          set oldprefs($v) [set $v]
>      }
>      ttk_toplevel $top
> @@ -11834,7 +11840,8 @@ proc prefscan {} {
>      global oldprefs prefstop
>
>      foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
> -                   limitdiffs tabstop perfile_attrs hideremotes want_tt=
k} {
> +                   limitdiffs tabstop perfile_attrs hideremotes want_tt=
k \
> +                   hideprefetch} {
>          global $v
>          set $v $oldprefs($v)
>      }
> @@ -11848,7 +11855,7 @@ proc prefsok {} {
>      global oldprefs prefstop showneartags showlocalchanges
>      global fontpref mainfont textfont uifont
>      global limitdiffs treediffs perfile_attrs
> -    global hideremotes
> +    global hideremotes hideprefetch
>
>      catch {destroy $prefstop}
>      unset prefstop
> @@ -11894,7 +11901,8 @@ proc prefsok {} {
>            $limitdiffs !=3D $oldprefs(limitdiffs)} {
>          reselectline
>      }
> -    if {$hideremotes !=3D $oldprefs(hideremotes)} {
> +    if {$hideremotes !=3D $oldprefs(hideremotes) ||
> +          $hideprefetch !=3D $oldprefs(hideprefetch)} {
>          rereadrefs
>      }
>  }
> @@ -12368,6 +12376,7 @@ set cmitmode "patch"
>  set wrapcomment "none"
>  set showneartags 1
>  set hideremotes 0
> +set hideprefetch 1
>  set maxrefs 20
>  set visiblerefs {"master"}
>  set maxlinelen 200
> @@ -12480,7 +12489,7 @@ set config_variables {
>      filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
>      linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
>      indexcirclecolor circlecolors linkfgcolor circleoutlinecolor diffbg=
colors
> -    web_browser
> +    web_browser hideprefetch
>  }
>  foreach var $config_variables {
>      config_init_trace $var
> --
> 2.37.1.windows.1
>
>
>
