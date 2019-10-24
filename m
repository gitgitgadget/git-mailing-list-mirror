Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840F11F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 11:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436528AbfJXLlz (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 07:41:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47044 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439090AbfJXLly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 07:41:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so14905351wrw.13
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=faxzrzN3xGyfUC/tvs9xOF94xqVd26XQBMdRqP1aJJM=;
        b=FhTQptauwWVSzPRMwX+AgQa1b85MnYA0GRgmvQvwfktqy0vGVEUJXy69flMslsbWSY
         XYiVubFjE+6g+LZ27DK9VqR7dQiuaqNDeP32SOVX7A5fXdtUaHYej1NUlpP3wCwDXkP0
         Hl2aFbZ0RUMfcWdBCiI4vKjuXbeewpMV1KAWDgiV2957RB0YWV7KZTwKdyptkrVGALNP
         74Auydq8VC/BmmPiM2ob24voX/JRW2lN4DMKEwWpD8Inrnn1W5talmh5o3+ZQ+eEYz05
         aEaHpUoFEUTtJfsNhIUzS53SU1Dc9a7cgJ9pQ2acbfOvIaLqUyf7XtKyatQ3ce8mMBpf
         cSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=faxzrzN3xGyfUC/tvs9xOF94xqVd26XQBMdRqP1aJJM=;
        b=sFMvRKu8hFn72WORjFP95sjjuDlL6oNU6d1qFKh9T5sCLI8oAn5HJ//Psg5sjiCd6r
         XL/n8M262ZXdGcTY4qVpcqlvGtw2Zaa37v6+qkfF6YfPLX2YMY2qMmT/aWwlKJPJGIxB
         4Fsch0uPk8gr9m80k86RtwKtmVXGLIc4tI3Pqc/55ii9nxIzbd3tANOmOJjQ4htsgpgm
         Hlq1IwI1empJL4Sw0wfdB1SbOK/Ei0lj8VJrFJsEH9abfL3Vl492gBefIyMtI59xsV89
         +yfXFeWPgybEl51F9sTCL22JyNvDxDqvdUvNPdL+mfnqEbfj5/7K1UA+axDpRUpdCf3w
         DZQw==
X-Gm-Message-State: APjAAAVlK/yyVLf/E0CHjPwu9ji0vYk9gpxIsxYT82lqC7P23QQTNmBX
        uWWAXZSVqIgbqrFVppJ1jbw=
X-Google-Smtp-Source: APXvYqw7EFg8MHUEtoYeAPCAJ2A7gSidrHrNU2zlKWiaHfNsL0mhkLNgmSTRQz6DZmYDK2bKBH/bjw==
X-Received: by 2002:a5d:660c:: with SMTP id n12mr3361823wru.310.1571917311431;
        Thu, 24 Oct 2019 04:41:51 -0700 (PDT)
Received: from szeder.dev (x4dbd3359.dyn.telefonica.de. [77.189.51.89])
        by smtp.gmail.com with ESMTPSA id g11sm2071437wmh.45.2019.10.24.04.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 04:41:50 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:41:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and
 `is_directory()`
Message-ID: <20191024114148.GK4348@szeder.dev>
References: <20191024092745.97035-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191024092745.97035-1-mirucam@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 11:27:45AM +0200, Miriam Rubio wrote:
> The dir_exists() function in builtin/clone.c is marked as static, so
> nobody can use it outside builtin/clone.c.
> 
> There is also is_directory() which obviously tries to do the very same, but it uses a name that few developers will think of when they see file_exists() and look for the equivalent function to see whether a given directory exists.
> 
> Let's reconcile these functions by renaming is_directory() to dir_exists() and using it also in builtin/clone.c.

Please wrap the proposed log message at about 70 characters width;
that way it will look much better in 'git log' in a standard 80 char
wide terminal.

I think this is a cleanup worth doing, but...

> diff --git a/abspath.c b/abspath.c
> index 9857985329..13bd92eca5 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -5,7 +5,7 @@
>   * symlink to a directory, we do not want to say it is a directory when
>   * dealing with tracked content in the working tree.
>   */
> -int is_directory(const char *path)
> +int dir_exists(const char *path)
>  {
>  	struct stat st;
>  	return (!stat(path, &st) && S_ISDIR(st.st_mode));

Note the '&& S_ISDIR(st.st_mode)', making sure that the given path is
in fact a directory.  Good.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index c46ee29f0a..f89938bf94 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -899,12 +899,6 @@ static void dissociate_from_references(void)
>  	free(alternates);
>  }
>  
> -static int dir_exists(const char *path)
> -{
> -	struct stat sb;
> -	return !stat(path, &sb);

But look at this, it only checks that the given path exists, but it
could be a regular file or any other kind of path other than a
directory as well!

So this function clearly doesn't do what it's name suggests.  That's
bad.

Unfortunately, it gets worse: some of its callsites in
'builtin/clone.c' do expect it to check the existence of _any_ path,
not just a directory.

The first callsite is:

    dest_exists = dir_exists(dir);
    if (dest_exists && !is_empty_dir(dir))
            die(_("destination path '%s' already exists and is not "
                    "an empty directory."), dir);

I think this actually means path_exists(): if a file, or any other
kind of path with the given name were to exist, then we should die()
showing this error message, but after changing dir_exists() to make
sure that the path is indeed a directory we won't:

  # create a 'git' _file_
  $ >git
  # current git master:
  $ git clone https://github.com/git/git
  fatal: destination path 'git' already exists and is not an empty directory.
  # with this patch:
  $ ~/src/git/git clone https://github.com/git/git
  fatal: could not create work tree dir 'git': File exists

So the command still fails, which is good, but with a different error
message.  The test suite doesn't catch this, because the test case
looking at this scenario ('clone to an existing path' in
'./t5601-clone.sh') only checks that 'git clone' fails, but it doesn't
check whether it failed with the right error message.

Now, that other error message comes after a failed mkdir() call later
on which should have created the work tree.  So it begs the question
what would happen when a file is in the way of a bare clone:

  $ >git.git
  $ git clone --bare https://github.com/git/git
  fatal: destination path 'git.git' already exists and is not an empty directory.
  $ ~/src/git/git clone --bare https://github.com/git/git
  Cloning into bare repository 'git.git'...
  fatal: invalid gitfile format: /home/szeder/src/git/tmp/git.git

Then the next callsite looks like it meant path_exists() as well, but
I didn't try to make it fail or show different behavior:

    work_tree = getenv("GIT_WORK_TREE");
    if (work_tree && dir_exists(work_tree))
            die(_("working tree '%s' already exists."), work_tree);

And there is a third callsite, but I'm not sure what it is about, and,
consequently, what is really meant with dir_exists() here:

    if (real_git_dir) {
            if (dir_exists(real_git_dir))
                    junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;


