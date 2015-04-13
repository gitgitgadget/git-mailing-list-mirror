From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/7] path.c: implement =?UTF-8?Q?xdg=5Fconfig=5Fhome?=
 =?UTF-8?Q?=28=29?=
Date: Mon, 13 Apr 2015 17:50:49 +0200
Organization: gmx
Message-ID: <e1bc6f19af608db796a2212dbf00ba45@www.dscho.org>
References: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 17:51:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhgdY-00086v-R8
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 17:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbbDMPu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 11:50:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:54581 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932541AbbDMPu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 11:50:56 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LgdBZ-1ZD9J937B7-00nxQg; Mon, 13 Apr 2015 17:50:50
 +0200
In-Reply-To: <1428824772-8736-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:g0xbuIUsUSR8NHRLxg3v7r0ftT2b91SMuS5i3gOpBuXrjgVJlWs
 37gU4vr9eRPZGLuyKbUAliVyQtRcvIVGw0ZfnNJ4byNRU+jZsVh+JZ6W3XJmjRaGOewbu7v
 VRSHjlBT1GSHVl1MvhV2BBTrsrwHfYPqkVsQgkoqxfkMhRcUuJ3wRtmmA7JNP4EPQKAinEU
 phA9ZrsA2DfFAUdNUHHNw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267093>

Hi Paul,

maybe it would be a good idea to add a `0/7` mail that describes the overall goal of this patch series, much like a Pull Request? I found it very useful -- even for myself -- to set a description via `git branch --edit-description` and to let `git format-patch` use that via the `--cover-letter` option.

below just two minor nits because the rest of the patches looks fine to me:

On 2015-04-12 09:46, Paul Tan wrote:


> diff --git a/cache.h b/cache.h
> index 3d3244b..7f9bab0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -836,6 +836,13 @@ char *strip_path_suffix(const char *path, const
> char *suffix);
>  int daemon_avoid_alias(const char *path);
>  extern int is_ntfs_dotgit(const char *name);
>  
> +/**
> + * Returns the newly allocated string "$XDG_CONFIG_HOME/git/%s".  If
> + * $XDG_CONFIG_HOME is unset or empty, returns the newly allocated string
> + * "$HOME/.config/git/%s". Returns NULL if an error occurred.
> + */
> +extern char *xdg_config_home(const char *fn);

Should this not be inserted close to home_config_paths()? Also, the name "fn" sounds more like "function" than like "filename" to me, especially keeping the name `config_fn_t` in mind. Maybe call the parameter "filename" to avoid confusion?

Thanks,
Dscho
