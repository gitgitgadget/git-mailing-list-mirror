From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Sun, 13 Apr 2014 01:41:50 +0200
Message-ID: <5349CF3E.7010606@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53443F5C.7050400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 13 01:42:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ7Ye-0001Bh-6m
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 01:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631AbaDLXlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 19:41:55 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:47141 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbaDLXly (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 19:41:54 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so5300010eek.12
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xqxtK9qWzVIe3ahoZcRu5BQMCy79nZE9eGgZb4fljGo=;
        b=o2zFDFUilZe4vqVDWHVpTv0kU4tR3RQtvu5yPI/HBp/NPgciEbLklRhURI7wQ54VMy
         j4ozN+QdiJ+1uHtJ9uXKw0MlGVYSmL8n9f9hwj830PGLsVVztNxY3cKRps9hejXoCmOS
         iBYT1BhTfADdJOZR8SZP5DnVlRatAyD+rAnoy87CXOAPHRYm3I2upI0bd0qjRXTpQ6x5
         Ic2FJDzu3ByO6s7vA9tx/9cnUciGKi7fBjBoTyaHm7hp8YnJya4NvzXogyPNkRhxIRYi
         MBaoljDpnHm/EkYs2LO3+fvXpLcMES8SOE95BNc1aqbjzmVDoIA1U98TNjXxH3maIpD3
         AFTw==
X-Received: by 10.14.37.8 with SMTP id x8mr39569359eea.32.1397346113433;
        Sat, 12 Apr 2014 16:41:53 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id 4sm28794141eeq.33.2014.04.12.16.41.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 16:41:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53443F5C.7050400@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246204>

On 8. 4. 2014 20:26, Jens Lehmann wrote:
> Am 07.04.2014 23:46, schrieb Ronald Weiss:
>> Then, on top of that, I'll prepare patches for add to honor ignore
>> from .gitmodules, and -f implying --ignore-submodules. That might need
>> more discussion, let's see.
> 
> Makes sense.

I thought more about that, and also played with the code a bit.

First, I was confused when I wrote that git add doesn't honor
submodules' ignore setting only from .gitmodules, but it does from
.git/config. It doesn't, from neither. Sorry for the confusion. However,
that doesn't change anything on the fact that it would be nice if add
would honor the ignore setting, from both places.

Second, there are some differences between adding standard ignored
files, and ignored submodules:

1) Already tracked files are never ignored, regardless of .gitignore.
 However, tracked submodules should be ignored by "add -u", if told so
 by their ignore setting.

2) So .gitignore seems to only do something when adding new files to
 the repo. However, when adding new submodules, they are probably never
 ignored (setting the ignore setting for non existent submodule seems
 like non-sense, although possible).

3) Ignored files can be ignored less explicitely (in global gitignore,
 or using a wildcard, or by ignoring parent folder). So it makes sense
 to warn the user if he tries to explicitely add an ignored file, as he
 might not be aware that the file is ignored. Submodules, however, can
 only be ignored explicitely. And when user explicitely specifies the
 submodule in an add command, he most probably really wants to add it,
 so I don't see the point in warning him and requiring the -f option.

So, I think that the use cases are completely different, for submodules
and ignored files. So trying to make add behave the same for both, might
not be that good idea.

I would propose - let's make add honor the ignore setting by just
parsing if from config like the other commands do, and pass it to
underlying diff invocations. And at the same the, let's override it for
submodules explicitely specified on the command line, to never ignore
such submodules, without requiring the -f option. That seems to be
pretty easy, see below.


diff --git a/builtin/add.c b/builtin/add.c
index 85f2110..f19e6c8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -284,6 +284,10 @@ static int add_config(const char *var, const char *value, void *cb)
 		ignore_add_errors = git_config_bool(var, value);
 		return 0;
 	}
+
+	if (starts_with(var, "submodule."))
+		return parse_submodule_config_option(var, value);
+
 	return git_default_config(var, value, cb);
 }
 
@@ -320,6 +324,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	char *seen = NULL;
 
 	git_config(add_config, NULL);
+	gitmodules_config();
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
@@ -425,6 +430,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			       PATHSPEC_EXCLUDE);
 
 		for (i = 0; i < pathspec.nr; i++) {
+			int cachepos;
 			const char *path = pathspec.items[i].match;
 			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
 				continue;
@@ -440,6 +446,18 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 					die(_("pathspec '%s' did not match any files"),
 					    pathspec.items[i].original);
 			}
+
+			/* disable ignore setting for any submodules specified explicitly in the pathspec */
+			if (path[0] &&
+				(cachepos = cache_name_pos(path, pathspec.items[i].len)) >= 0 &&
+				S_ISGITLINK(active_cache[cachepos]->ce_mode)) {
+				char *optname;
+				int optnamelen = pathspec.items[i].len + 17;
+				optname = xcalloc(optnamelen + 1, 1);
+				snprintf(optname, optnamelen + 1, "submodule.%s.ignore", path);
+				parse_submodule_config_option(optname, "none");
+				free(optname);
+			}
 		}
 		free(seen);
 	}
--  
