From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: Re: git-who
Date: Wed, 8 Oct 2008 00:59:45 -0400
Message-ID: <70ED45EF-54B8-42D9-98BA-F2E98C786419@gmail.com>
References: <DE2CF127-A7FD-4765-A8E4-5235C5F1B9A9@gmail.com> <20081008022505.GB29313@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 07:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnRAy-0003fV-Jb
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 07:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbYJHE7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 00:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYJHE7v
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 00:59:51 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:57895 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109AbYJHE7u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 00:59:50 -0400
Received: by gxk9 with SMTP id 9so7626083gxk.13
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 21:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=ShvjkTb4rYxcw2qt9z8lw1VRlxtY/FBcQnY9TcZ6H2A=;
        b=OlGpRwmn1D8q/IJi+alEJ0poj33yg6eLVa41B46iXWIS6/hjaZS+F65aghZkyy2N87
         WK5+rdGBTqOA3klMZQP7ebmFQc7Q71W8HM5BYZz/OOHT4PhiFJyz7+U2weuI1+pswuIl
         /RGTshrPOz3Ogtsf/Fr55XY4A8af2vDJWk0t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=jdnaPfUqB5CC0E2R0tuYC0ouKAM/EpWbnWJ/7iqm3JqlYgQ3XD6IHasjIaXuyd5j1N
         SvPyM42HygoSZ8VOfjdsQc2MaWVLja5yYVIPxFb+MLq04rkLS6kTcFf7VsDs0LMxtWYR
         XMDd+TfvYkyf/bOWSRZPgopgjZzWeL4kYQC7o=
Received: by 10.90.98.12 with SMTP id v12mr8643599agb.6.1223441988635;
        Tue, 07 Oct 2008 21:59:48 -0700 (PDT)
Received: from ?192.168.1.103? (c-65-96-170-12.hsd1.ma.comcast.net [65.96.170.12])
        by mx.google.com with ESMTPS id 33sm2458725wra.25.2008.10.07.21.59.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Oct 2008 21:59:47 -0700 (PDT)
In-Reply-To: <20081008022505.GB29313@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97758>


On Oct 7, 2008, at 10:25 PM, Jeff King wrote:

> On Tue, Oct 07, 2008 at 05:02:46PM -0400, Kate Rhodes wrote:
>
>> As is it's probably not worth including in git, but I'm thinking that
>> someone else can probably come up with some improvements, such as  
>> dates in
>> the verbose mode, support for a treeish instead of a single file  
>> path, and
>> / or rewriting it in C so that it can work on Windows.
>
> Scripts like this often find a good home in git's contrib/ directory.
> Consider submitting a patch which adds it there.
>
>> git://github.com/masukomi/git_accessories.git
>
> I took a look. My biggest complaint is that for many files, it  
> produces
> too many names.

Yeah, I agree, I just haven't come up with a better idea that  
addresses the question of "who touched this". Maybe some sort of  
recency toggle.

> It would be nice to at least sort the names by number
> of commits. But even more accurate might be the number of added lines.
> Somebody who creates a 200-line file should surely come before  
> somebody
> who made a 1-line tweak, right?

Yeah, I've considered maybe adding a -n (number) like that and  
ordering people by number of commits. I'm not convinced that, in most  
cases, size of changes is as important as number.  I think it depends  
on the file. In some cases a person who's constantly mucking about  
with the file is a better go-to person when you have questions /  
issues, than someone who happened to make a few large commits a while  
ago. But then again....


>
> But perhaps even more accurate would be to rely on blame output, since
> it attributes not just added lines, but lines which have actually
> survived into the current product.

mmm good idea.


> And fortunately that is relatively
> easy to do (only lightly tested):

excellent! Thank you. I'll poke at this tomorrow. :)

-masukomi

>
>
> -- >8 --
> #!/usr/bin/perl
> #
> # Invoke as 'git who -M -C file.c' (or whichever blame options
> # you prefer). You can even check a particular set of lines
> # with "git who -M -C -L 40,60 file.c".
>
> use strict;
>
> open(my $in, '-|', qw(git blame -p), @ARGV);
>
> my %count;
> my %author;
> my $current_sha1;
> while(<$in>) {
>  if (!$current_sha1) {
>    /^[0-9a-f]{40}/ or die "expected sha1, got $_";
>    $current_sha1 = $&;
>    $count{$current_sha1}++;
>  }
>  elsif (/^author (.*)/) {
>    $author{$current_sha1} = $1;
>  }
>  elsif (/^\t/) {
>    $current_sha1 = undef;
>  }
> }
>
> my %acount;
> while(my ($h, $c) = each %count) {
>  $acount{$author{$h}} += $c;
> }
>
> foreach (sort { $acount{$b} <=> $acount{$a} } keys %acount) {
>  print "$_ ($acount{$_})\n";
> }
