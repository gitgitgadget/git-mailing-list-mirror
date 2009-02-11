From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 22:03:13 +0200
Message-ID: <8e04b5820902111203t344881f6g31f25cfbff5fd822@mail.gmail.com>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
	 <20090211180559.GC19749@coredump.intra.peff.net>
	 <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
	 <20090211184429.GA27896@coredump.intra.peff.net>
	 <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
	 <20090211191445.GU30949@spearce.org>
	 <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
	 <20090211192245.GA28832@coredump.intra.peff.net>
	 <8e04b5820902111132v5b7c8e14s15c6fad13b5b76a9@mail.gmail.com>
	 <20090211194218.GA28927@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 21:05:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXLKO-0004x9-KY
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 21:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756324AbZBKUDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 15:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757658AbZBKUDT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 15:03:19 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:47710 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757506AbZBKUDP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 15:03:15 -0500
Received: by bwz5 with SMTP id 5so542445bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bRERgLUMUhg09q/+u0Zb7EvtzYmFbM9q8CGpce1iEVQ=;
        b=uA7ormdPIUyQl1LM4B3JPKoeJLQadpAv63kgvfZGxOhgOLDyHfH/GW8Z9FeDsKM7+W
         CJci17pZ5k2BtkR+1RpEII43hHc+ewkyRWAp3EK+fFtqBa91x0Lw6ZrMR5zCXRxPRtke
         FgN4Q9MLleKEa/qPoVIvUIGa/tfg0W8suvKFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QrmnEUlgP0NfNyaiiD80xPR7WXbvmvkldzsyk5QgHraJJbnvYD18paidtZTZk3bNH4
         /1Be8TTcHR+EBYnXyiHqE/KhIS3r2nwCoLfCa12VaLkFOBNQ1TZCc3DoB85oOIVwwwUi
         +4RlSh3amqHr9Sa806aDJmNHg3EXubKUU+GyE=
Received: by 10.181.192.11 with SMTP id u11mr8088bkp.50.1234382593704; Wed, 11 
	Feb 2009 12:03:13 -0800 (PST)
In-Reply-To: <20090211194218.GA28927@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109520>

    I'll merge both Junio's and Jeff's emails into one... My answers bellow.


On Wed, Feb 11, 2009 at 9:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> writes:
>
>> On Wed, Feb 11, 2009 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> And why isn't it in $HOME/bin/?
>>
>>     No, it is inside .git/bin folder.
>
> You are not answering my question.
>
> I questioned the sanity of putting the scripts in .git/bin/ per
> repository.  Why shouldn't a useful script like your "branch-import"
> available to _all_ your repositories, possibly taking customization per
> repository from repository's .git/config file, so that it does what is
> appropriate in each repository?

    Indeed my problem could be solved by either of the solutions
proposed (I'll summarize them for the sake of completeness):
    * using git alias to put simple inline scripts (without need of a
new file), or to put the path to the real script;
    * putting the new command into a directory that is referenced from PATH;

    Both these solutions work fine, except one concern: when moving
the repository I would also want to move my scripts, and so I'm
remaining with only one candidate: git aliases... (For example I could
move the repository to another machine that I haven't setup with my
own scripts... Of course neither my solution would work, because I
would need a patched Git, but this could be changed if Git would have
this feature built-in :) )

    But, there is a disadvantage with git aliases, meaning if I want a
bigger script then I must keep in sync both config file and script
names... Moreover, if I use git from another folder than the work-tree
would the alias still work if I used relative paths? (I don't know but
someone could clear this up as there is no mention about it in the
documentation...)

    So my proposal is very simple: make git look inside the GIT_DIR
and see if there is a bin folder; if so add it in the front of path
(thus overriding built-in commands??).

    The advantage is that is much simpler to setup commands by just
dropping git-something files inside .git/bin... No config editing, no
relative path problems...

    As a conclusion, I've patched Git myself to support such a
feature... (See patch bellow...)

    So? Having explained in detail the problem and solutions what is
(are) yours (or others) opinions?


On Wed, Feb 11, 2009 at 9:42 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 11, 2009 at 09:32:29PM +0200, Ciprian Dorin, Craciun wrote:
>
>>     Anyway, I don't see why it's wrong to have such a bin folder per
>> repository... Let's for a moment assume that there is a use case for
>> such a thing, I'm wondering what is wrong with this solution from a
>> Git perspective???
>
> It's not _wrong_, we're just suggesting ways that the same thing might
> be accomplished more easily.
>
>>     P.S.: It seems that indeed setup_git_directory_gently (or
>> something in the setup system) is kind of broken if I call it twice...
>
> Yes, I think your patch is running into a long-standing problem in the
> git initialization code. There are problems if you need to look into the
> repo dir to find out which command to execute, because finding the repo
> dir changes the environment. There is a similar problem with aliases.
>
> So I think getting your patch to run correctly may be hard. But I admit
> I didn't look at it that closely.
>
> -Peff

    :) I've skipped around the problem (in a non-engineering way) by
adding a variable which enables or disables my feature... And I only
enable it for git.c... :)


    Thanks both Junio, Jeff and Shawn for your answers!
    Ciprian Craciun.

    P.S.: My final (working (hopefully, although tested)) patch bellow.

--------

diff --git a/exec_cmd.c b/exec_cmd.c
index cdd35f9..8d707e1 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -44,6 +44,45 @@ const char *git_exec_path(void)
 	return system_path(GIT_EXEC_PATH);
 }

+/* Returns the path of the bin folder inside the .git folder. */
+/* (This could be used to store repository specific git programs.) */
+
+int enable_git_repo_exec_path = 0;
+
+const char *git_repo_exec_path(void)
+{
+	static char path_buffer[PATH_MAX + 1];
+	static char *path = NULL;
+	
+	int non_git;
+	const char *git_dir;
+	
+	if (!path && enable_git_repo_exec_path) {
+		
+		path = path_buffer;
+		path[0] = '\0';
+		
+		setup_git_directory_gently(&non_git);
+		
+		if (!non_git) {
+			
+			git_dir = get_git_dir();
+			
+			strncat(path, git_dir, PATH_MAX);
+			strncat(path, "/", PATH_MAX);
+			strncat(path, "bin", PATH_MAX);
+			strncpy(path, make_absolute_path(path), PATH_MAX);
+			if (access(path, F_OK) != 0)
+				path[0] = '\0';
+		}
+	}
+	
+	if (!path || (path[0] == '\0'))
+		return NULL;
+	
+	return path;
+}
+
 static void add_path(struct strbuf *out, const char *path)
 {
 	if (path && *path) {
@@ -61,6 +100,8 @@ void setup_path(void)
 	const char *old_path = getenv("PATH");
 	struct strbuf new_path = STRBUF_INIT;

+	if (git_repo_exec_path() != NULL)
+		add_path(&new_path, git_repo_exec_path());
 	add_path(&new_path, argv_exec_path);
 	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
 	add_path(&new_path, system_path(GIT_EXEC_PATH));
diff --git a/exec_cmd.h b/exec_cmd.h
index 594f961..a02256b 100644
--- a/exec_cmd.h
+++ b/exec_cmd.h
@@ -10,4 +10,6 @@ extern int execv_git_cmd(const char **argv); /* NULL
terminated */
 extern int execl_git_cmd(const char *cmd, ...);
 extern const char *system_path(const char *path);

+extern int enable_git_repo_exec_path;
+
 #endif /* GIT_EXEC_CMD_H */
diff --git a/git.c b/git.c
index 940a498..d312ab9 100644
--- a/git.c
+++ b/git.c
@@ -477,6 +477,7 @@ int main(int argc, const char **argv)
 	 * environment, and the $(gitexecdir) from the Makefile at build
 	 * time.
 	 */
+	enable_git_repo_exec_path = 1;
 	setup_path();

 	while (1) {
