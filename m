From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sat, 28 Sep 2013 18:06:22 -0500
Message-ID: <CAMP44s0JnG8wQ6DhHxbrdoxhdt3UTC8WG6R2yVmctGntEx0yzQ@mail.gmail.com>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
	<20130921212904.GA235845@vauxhall.crustytoothpaste.net>
	<CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
	<20130921235647.GC235845@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Sep 29 01:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ3am-0001EM-3n
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 01:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab3I1XGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 19:06:25 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33497 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab3I1XGX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 19:06:23 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so3337768lbi.39
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=leSzXeeuVCSM+YXKkiSSX4uwTMVb2yrnAM3sloNw77o=;
        b=jUyB1ej+j/GmY9t/1gIbz7GwwQDutWSOGrOiThejrpG8qWEAQewnJxPCFXD9YdqMST
         qbeuU4wrovCo2HYkHsEWfJd8trkug7RyRnZaEW6g+rDNR7wfNA+/LVRBJYCU7lTdci0Y
         VRv92bJIROjgq+CpQrytcWPQHQ2dEvUctP8GvUBHnyfqPcxdCUMyreFGgP+XUOuO+QFA
         Ke0sxXYtUhkWac7KtQcd50pRHK+RxOerBbUCSiN13umas43CLaug3AArnfICAejyCafj
         U7hydZNTPBcTkIGE/u6FJKYfiwiPfJHpp23vyxigALPerlKY7pf1suezggXRZ4nxZdaN
         dfcw==
X-Received: by 10.152.45.106 with SMTP id l10mr12594352lam.12.1380409582325;
 Sat, 28 Sep 2013 16:06:22 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sat, 28 Sep 2013 16:06:22 -0700 (PDT)
In-Reply-To: <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235568>

On Sat, Sep 21, 2013 at 6:56 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sat, Sep 21, 2013 at 05:52:05PM -0500, Felipe Contreras wrote:
>> On Sat, Sep 21, 2013 at 4:29 PM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:

>> Now, if anybody has ideas into how the bindings could be more object
>> oriented, I'm all ears, but unfortunately what I foresee is that
>> nobody will consider this proposal seriously.
>
> My concern is that the Ruby code will end up not being idiomatic, and
> people will view it as bizarre and unmaintainable.
>
> for_each_ref could end up being something like REPOSITORY.refs.each,
> which would be more idiomatic.  repository.refs would probably be an
> Enumerator in that case.  If the decision is made to incorporate Ruby
> code, I'm happy to submit some patches to help provide a sane interface,
> even though I'm not that familiar with Ruby.

I think my proposed bindings are quite idiomatic.

git ruby - master origin/master <<EOF
commits = ARGV.map { |id| Git::Commit.get(get_sha1(id)) }
puts get_merge_bases(commits, 0).map { |commit| sha1_to_hex(commit.sha1) }
EOF

-- 
Felipe Contreras
