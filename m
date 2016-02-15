From: Tim Ringenbach <tim.ringenbach@gmail.com>
Subject: Re: git svn dcommit doesn't support --username option for file:/// urls
Date: Mon, 15 Feb 2016 13:16:48 -0600
Message-ID: <CAGZMbfdem6YzrEUw9A6ZWAbm6zXkNxqM3myAjHz4xFDS79VYwA@mail.gmail.com>
References: <CAGZMbfc5Oi=EOYbCbZWfM1T65AZwCEbsso+QTkAe1sa4hRC61A@mail.gmail.com>
	<20160215100636.GA5785@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 20:16:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVOdi-0007eM-4E
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 20:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbcBOTQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 14:16:50 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33614 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbcBOTQt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 14:16:49 -0500
Received: by mail-ob0-f173.google.com with SMTP id jq7so40887392obb.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hKkBySfits2hpDyUbUdbb52bQU+SpJGSp193VrLX754=;
        b=YPuMOtUYJ10BgpkrTVTozxwvMrF2VvbretzdgAfUYp6V70qOLjNeBEHeEqZZqOHN2b
         Fk+dhHn5LTBJF0+hU7ILcSoJhNDW5HkjQwCqOO2hhEpEOEi/1YL5EZb33Ng0gYJX3CwQ
         1WZnsPeyO7uJR8MxbgZIJnqWjIq67j5f8ElrVuqzBLDZi067gDSP5PQ/6Ybqd7SMdPOz
         zGWFcHebx9Thp3qtC2sEBxFhzbjjZyiTOD7AMC5rbX86GCGCiI4n3if0hk39rXx7V8NF
         pzoxtvB3mdfM13+fXQz6j88amxmR0V9uixpMpMTFurCTGPLnOgQZ41Nc2P+xYKoSl6nF
         BDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hKkBySfits2hpDyUbUdbb52bQU+SpJGSp193VrLX754=;
        b=jO0m7mFqAOOya9w6ayryOf8Q4r1o+nS2Sv/zjVqPjcY5fBCCP8wl6uVqv6WpmTlpxP
         7hwmiQ5ewHREKCF9m7dlUuowndPx8cZFsiW47l/9PbT1Gbbv2WoLL7lgLh/XEBXadJ0V
         oJ0ZNnAUN7jxTllHhKw4xZqKKsJnau6qm8gL3JKeu7QwJgsbZ3r4kM5d0fmEvfnzBGWo
         wqaPF5WdwcFR5dTruQ24DO1746feOOJu+vxLux5EYMVwa2WuFKrX6lXcegXZ8NFR8SqH
         chBugJ8vpafg/c7hUZJU9xNoDZ3Jb5OuCk3rD/00Yg+XhZ/MT4MSiT5TeXV+FvdzezSd
         GyQQ==
X-Gm-Message-State: AG10YOT6PGFeu+avIN7P1C1hsrh5Q61TlfODmnSXaQxafewbMZ9fs2s7+6HJTy1Z0fiO2y0fnZk66AW40fnK6A==
X-Received: by 10.182.250.169 with SMTP id zd9mr13449692obc.59.1455563809014;
 Mon, 15 Feb 2016 11:16:49 -0800 (PST)
Received: by 10.202.49.193 with HTTP; Mon, 15 Feb 2016 11:16:48 -0800 (PST)
In-Reply-To: <20160215100636.GA5785@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286230>

On Mon, Feb 15, 2016 at 4:06 AM, Eric Wong <normalperson@yhbt.net> wrote:
[snip]
> Totally untested, but does flipping the order of auth providers
> help at all?

Thanks for looking into this. Unfortunately, that didn't seem to make
a difference.
I tried several times, and I tried both with and without
--interactive, but the commits
always shared up as my unix user.

I added a "print "test\n";" to make sure my modify copy was being
used, and I did see
that output, so I know I was running the right code.

For reference, here's what diff outputs on my side.

--- git-2.7.1/perl/Git/SVN/Ra.pm 2016-02-05 17:31:08.000000000 -0600
+++ local/share/perl/5.10.1/Git/SVN/Ra.pm 2016-02-15 13:06:27.000000000 -0600
@@ -42,7 +42,9 @@ END {

 sub _auth_providers () {
  require SVN::Client;
+ print "test\n";
  my @rv = (
+  SVN::Client::get_username_provider(),
   SVN::Client::get_simple_provider(),
   SVN::Client::get_ssl_server_trust_file_provider(),
   SVN::Client::get_simple_prompt_provider(
@@ -53,7 +55,6 @@ sub _auth_providers () {
   SVN::Client::get_ssl_client_cert_pw_file_provider(),
   SVN::Client::get_ssl_client_cert_pw_prompt_provider(
     \&Git::SVN::Prompt::ssl_client_cert_pw, 2),
-  SVN::Client::get_username_provider(),
   SVN::Client::get_ssl_server_trust_prompt_provider(
     \&Git::SVN::Prompt::ssl_server_trust),
   SVN::Client::get_username_prompt_provider(


Thanks,
Tim
