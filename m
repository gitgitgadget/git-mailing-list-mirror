From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Thu, 18 Oct 2012 07:18:49 +0200
Message-ID: <CAMP44s1b=dNaCbm1WkFBv6368Y+jDYdkPuscEFdiUnVJBStfVg@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<20121017225913.GC21742@sigill.intra.peff.net>
	<CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOiVZ-0005mD-QV
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 07:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040Ab2JRFSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 01:18:50 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49956 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2JRFSt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 01:18:49 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so8226605oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 22:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KzS1phgQ97Et/BX5mgv81D98+cUAuHPJIjj3mZSVs5I=;
        b=fEtcDhuI8gci6dUrb7Buoiqr+VO7HtCWvD7MJxbgqxW+Tfm1ndEy5ixA7iCZNFxKNS
         rwPA5hF0EUfpBmNXf9x7RKWxuF0FvZO+nAQ4FUnFgQLj3UDfgvJ3DhYInqEXZLnzJ706
         gwYT/9X+VXRW2qkAndJjOAWj9dm/uvE8z+koJ2gAODFb01J1+0qzW8WZPLoCZ1IdoAaU
         8wRU/OHuMyWJQ7wDkEqwGnUYCePteUhwe0MSTFI9X2+u6MK2eTyKUj5YlTFRqeWtHDHC
         LGSF6fmrJ+I8gBhwoLtGBnBTfnYMR0HREy/FirJWiOeNur/nL1LG85/RvkAiB6krFqb7
         bmiA==
Received: by 10.60.170.179 with SMTP id an19mr12902630oec.46.1350537529341;
 Wed, 17 Oct 2012 22:18:49 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 22:18:49 -0700 (PDT)
In-Reply-To: <CAMP44s0+Fhtj2rMQ1Av-49Koa=DumX8JZs5angOFSRzqtDc+9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207958>

On Thu, Oct 18, 2012 at 5:44 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Oct 18, 2012 at 12:59 AM, Jeff King <peff@peff.net> wrote:
>> On Wed, Oct 17, 2012 at 02:58:41PM +0200, Felipe Contreras wrote:
>>
>>> I've looked at many hg<->git tools and none satisfy me. Too complicated, or too
>>> slow, or to difficult to setup, etc.
>>
>> I run into this every few months, evaluate all of the options, and come
>> to the same conclusion. So I am excited at the prospect of something
>> simple that just works out of the box.
>>
>> Unfortunately, when I tried it, it did not work for me. :(

Ok, I've fixed all those issues:
http://github.com/felipec/git/blob/fc-remote-hg/contrib/remote-hg/git-remote-hg

Right now I've just added an error when using remote repositories. But
it seems there's no way around it; if we want to have support for
remote repos, we need to make a local clone.

> But at the moment it should fail at this point, I wonder why you get
> the errors below.
>
>>   error: refs/tags/VIMPERATOR_2_2_b1 does not point to a valid object!
>>   error: refs/tags/muttator-0.5 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b1 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b2 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b3 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b4 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b4.1 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b4.2 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b4.3 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b5 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b5.1 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b6 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b7 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0b7.1 does not point to a valid object!
>>   error: refs/tags/pentadactyl-1.0rc1 does not point to a valid object!
>>   error: refs/tags/vimperator-0.4.1 does not point to a valid object!
>>   error: refs/tags/vimperator-0.5 does not point to a valid object!
>>   error: refs/tags/vimperator-0.5-branch-HEAD-merge-1 does not point to a valid object!
>>   error: refs/tags/vimperator-0.5.1 does not point to a valid object!
>>   error: refs/tags/vimperator-0.5.2 does not point to a valid object!
>>   error: refs/tags/vimperator-0.5.3 does not point to a valid object!
>>   error: refs/tags/vimperator-1.0 does not point to a valid object!
>>   error: refs/tags/vimperator-1.1 does not point to a valid object!
>>   error: refs/tags/vimperator-1.2 does not point to a valid object!
>>   error: refs/tags/vimperator-2.0 does not point to a valid object!
>>   error: refs/tags/vimperator-2.0a1 does not point to a valid object!
>>   error: refs/tags/vimperator-2.1 does not point to a valid object!
>>   error: refs/tags/vimperator-2.2 does not point to a valid object!
>>   error: refs/tags/vimperator-2.2b1 does not point to a valid object!
>>   error: refs/tags/xulmus-0.1 does not point to a valid object!
>
> This is weird.

I think I know why the errors above show up; even though the helper
dies, transport-helper doesn't check the status until the very end.

Something like this should do the trick:

diff --git a/run-command.c b/run-command.c
index 1101ef7..0a859ca 100644
--- a/run-command.c
+++ b/run-command.c
@@ -559,6 +559,21 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }

+int check_command(struct child_process *cmd)
+{
+	int status;
+	pid_t pid;
+
+	pid = waitpid(cmd->pid, &status, WNOHANG);
+
+	if (pid != cmd->pid)
+		return -1;
+	if (WIFSIGNALED(status))
+		return WTERMSIG(status);
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+}
+
 static void prepare_run_command_v_opt(struct child_process *cmd,
 				      const char **argv,
 				      int opt)
diff --git a/run-command.h b/run-command.h
index 44f7d2b..9019e38 100644
--- a/run-command.h
+++ b/run-command.h
@@ -45,6 +45,7 @@ struct child_process {
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
+int check_command(struct child_process *cmd);

 extern int run_hook(const char *index_file, const char *name, ...);

diff --git a/transport-helper.c b/transport-helper.c
index cfe0988..bc1349d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -441,6 +441,10 @@ static int fetch_with_import(struct transport *transport,

 	if (finish_command(&fastimport))
 		die("Error while running fast-import");
+
+	if (check_command(data->helper))
+		die("Error while running helper");
+
 	free(fastimport.argv);
 	fastimport.argv = NULL;

@@ -784,6 +788,10 @@ static int push_refs_with_export(struct transport
*transport,

 	if (finish_command(&exporter))
 		die("Error while running fast-export");
+
+	if (check_command(data->helper))
+		die("Error while running helper");
+
 	push_update_refs_status(data, remote_refs);
 	return 0;
 }

-- 
Felipe Contreras
