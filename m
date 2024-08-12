Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E317C9E7
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723471869; cv=none; b=dJOItIq3qa7zOirzrM9znFjCb6J52ZkLeGMbUg16wnyjF5eno/3yfOo7bmuhn7QiAsytHNhO4ycyG5TGlcGuFgayTCSHyL73U/88OlrGvEMoXyEdLcdkWqAAxZOHBG/r5dwOrxPojkxKPxGbvzaWG8Pgk4Y8MITEwuZgQk5RfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723471869; c=relaxed/simple;
	bh=jWbq2jUe8RukgBNhMMZPfXdfl36ffdsjdy65gykb0G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4KJC42a3+/q29TFjUqhMVVYznlFYFuv0FngB+OWG2chUe241E1nRIeLdi8hEQyjrKReqqlUOpi8Mnpl9KhP/vGM3uiwfhs5apxvZTruZKv7i+owZ4clMculcLLlmxMuLWGxdmhvWadCyma1Xuz2EC44TdYqiBGgto1XfwdaqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LC8AIAKM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LC8AIAKM"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe9cf83c7so24088021cf.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723471867; x=1724076667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=egN1vmPQOFk86ftAAA2vwqQCbvqu2sR0uOArnnSDlO0=;
        b=LC8AIAKMYkVgGf58z0ZzyRn7lUx44LhVxY8o+Pnu5oHIF+1WXovy5MfqnHbiZoISt4
         fp3UlbvpjYYAr6WoQEDBkoVR+8bg3hgZiOcfDd/IzK9NxG3yLHnWA3OZRRN0eqWxbVj/
         wCK5ydw5PCx0h+7zMwpeB8fSpjR9bwnTQek+LwcpQpG6tqvOdDVcmeQ1CxWZrMmyisyG
         zJx18AjvRjwV0UquuFDQ0qwNzzdqqfvSk/vBBtFlyVhIo4JvfrmnFcMFjOoNN0+Xkxta
         lPDKjxFx2NNHMznf0AnuxZIF30NLT9pUZ8zkVfKDKi1JV667qMcG8o42ynkiTZAjLiHJ
         hl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723471867; x=1724076667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egN1vmPQOFk86ftAAA2vwqQCbvqu2sR0uOArnnSDlO0=;
        b=TeYBYGk+GYI5FF4XNwSy9nWSrrc+NpV4jZB8kzcRtaMH1GU0c8zBK5KNdvtKjB7dKm
         +jghSVX7DTVP4Lf1i4wWDSUMKUEiLjSBDcc1gxOzVGfp3UsjYdSVlA/ThhbyNd4eSOJB
         yTlEiwdaAibFf5lkaqmc5aN7p+++VSbhGI/2qCUSwONpYnEwDdmvFGZfTlT0LWCBdKWu
         1QHsj/A93TMI/6l+3H7N6fPWtHAd2ldoqIvQuQFw7aCrym/bMVKPw2learXA296Od6TZ
         lvDHXCZd6HAAcMeN+9ZO8fthE+bWIhM/JBqgiBCKr6IkPBPRDLHq0ZC5bQ8bx4CfR8z0
         EzuA==
X-Gm-Message-State: AOJu0Yz/wwBlVUjbypYW29nOH484O3dSH/yL612DUDVJ3SBbxbJlTG0b
	lukkEbqFOjvuJsTfua4u6np5U36FubNiw1j6Tf3Z01cLXILFKn/GQnIMD3X7jFg=
X-Google-Smtp-Source: AGHT+IEHw2qlt5s0SpDiD45sA14slGnvCg6M+1stL213SYr7Qb7cSlxoMotZ3/0kn6/6F5/HVvMM3g==
X-Received: by 2002:a05:622a:5e13:b0:447:ef7c:edb7 with SMTP id d75a77b69052e-45349943244mr5533121cf.26.1723471867066;
        Mon, 12 Aug 2024 07:11:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c291915sm23473561cf.83.2024.08.12.07.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:11:06 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:11:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 02/22] git: fix leaking system paths
Message-ID: <ZroX+SSgTe7YnWHS@nand.local>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
 <324140e4fdee54fbf0054e76abb287b7212fd21e.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <324140e4fdee54fbf0054e76abb287b7212fd21e.1723121979.git.ps@pks.im>

On Thu, Aug 08, 2024 at 03:04:39PM +0200, Patrick Steinhardt wrote:
> Git has some flags to make it output system paths as they have been
> compiled into Git. This is done by calling `system_path()`, which
> returns an allocated string. This string isn't ever free'd though,
> creating a memory leak.
>
> Plug those leaks. While they are surfaced by t0211, there are more
> memory leaks looming exposed by that test suite and it thus does not yet
> pass with the memory leak checker enabled.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/git.c b/git.c
> index e35af9b0e5..5eab88b472 100644
> --- a/git.c
> +++ b/git.c
> @@ -173,15 +173,21 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  				exit(0);
>  			}
>  		} else if (!strcmp(cmd, "--html-path")) {
> -			puts(system_path(GIT_HTML_PATH));
> +			char *path = system_path(GIT_HTML_PATH);
> +			puts(path);
> +			free(path);
>  			trace2_cmd_name("_query_");
>  			exit(0);
>  		} else if (!strcmp(cmd, "--man-path")) {
> -			puts(system_path(GIT_MAN_PATH));
> +			char *path = system_path(GIT_MAN_PATH);
> +			puts(path);
> +			free(path);
>  			trace2_cmd_name("_query_");
>  			exit(0);
>  		} else if (!strcmp(cmd, "--info-path")) {
> -			puts(system_path(GIT_INFO_PATH));
> +			char *path = system_path(GIT_INFO_PATH);
> +			puts(path);
> +			free(path);
>  			trace2_cmd_name("_query_");
>  			exit(0);
>  		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {


Makes sense, though I wonder if this would be slightly cleaner to write
like so (applies on top of this patch):

--- 8< ---
diff --git a/git.c b/git.c
index 5eab88b472..9a618a2740 100644
--- a/git.c
+++ b/git.c
@@ -143,6 +143,13 @@ void setup_auto_pager(const char *cmd, int def)
 	commit_pager_choice();
 }

+static void print_system_path(const char *path)
+{
+	char *s_path = system_path(path);
+	puts(s_path);
+	free(s_path);
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
@@ -173,21 +180,15 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				exit(0);
 			}
 		} else if (!strcmp(cmd, "--html-path")) {
-			char *path = system_path(GIT_HTML_PATH);
-			puts(path);
-			free(path);
+			print_system_path(GIT_HTML_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--man-path")) {
-			char *path = system_path(GIT_MAN_PATH);
-			puts(path);
-			free(path);
+			print_system_path(GIT_MAN_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "--info-path")) {
-			char *path = system_path(GIT_INFO_PATH);
-			puts(path);
-			free(path);
+			print_system_path(GIT_INFO_PATH);
 			trace2_cmd_name("_query_");
 			exit(0);
 		} else if (!strcmp(cmd, "-p") || !strcmp(cmd, "--paginate")) {
--- >8 ---

Thanks,
Taylor
