From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Tue, 2 Sep 2008 13:50:38 -0400
Message-ID: <32541b130809021050g22a7cb0blfde151844e6e8851@mail.gmail.com>
References: <20080830173947.GF7185@schiele.dyndns.org>
	 <20080830183413.GG7185@schiele.dyndns.org>
	 <20080830183949.GA16415@coredump.intra.peff.net>
	 <200808302237.17017.jnareb@gmail.com>
	 <32541b130808302235g6a23efcfs78efe2ef557cd9c7@mail.gmail.com>
	 <20080901214254.GA8058@blimp.localhost>
	 <32541b130809011723l1cd8abfid9228363f952875@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Jeff King" <peff@peff.net>,
	"Robert Schiele" <rschiele@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:52:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaa2d-0001Un-1D
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 19:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbYIBRuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 13:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbYIBRuk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 13:50:40 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:46945 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYIBRuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 13:50:39 -0400
Received: by gxk9 with SMTP id 9so5529473gxk.13
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fhLa8JkPOOYSGYtqeRmvyY7XRf9CJqhVncCeFGKgdk8=;
        b=UrqR8RTS/SXpouQiZQJTR8twVtVhjRgGeZIVOFmh4FA+0YFnMJ6fqQdZy24KO2PyjL
         EG0G5u10SRtiK2+RHu5uKcO5oyB5U7UnhY+yy5PO+3kzLblGix7f5mlaijFJFncZC4EO
         P1sKB4OtXkWcStGF1crJ61o5rNczTosQM37G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xzbsylR26vyZEnS4birwdX54HUUDllOXL8H0KjwhsqAWarGc75deYoGWiCrx15Z2kr
         qaGlM0u9g+P4QIB6ymORdXrrSIfIuiMNJO53zqTwuf7SCV1zdq5h2F7nsYKsuQXRWQJi
         icn8CneKdTzZvVlQlyVi6Eeb9DcLbmrrv2W54=
Received: by 10.151.100.17 with SMTP id c17mr10921871ybm.2.1220377838591;
        Tue, 02 Sep 2008 10:50:38 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Tue, 2 Sep 2008 10:50:38 -0700 (PDT)
In-Reply-To: <32541b130809011723l1cd8abfid9228363f952875@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94685>

On Mon, Sep 1, 2008 at 8:23 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Mon, Sep 1, 2008 at 5:42 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>> Avery Pennarun, Sun, Aug 31, 2008 07:35:31 +0200:
>>> On Sat, Aug 30, 2008 at 4:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>> > Or you can use "open $fd, '-|'" to fork, an "manually" exec/system.
>>>
>>> Shell quoting is a disaster (including security holes, where relevant)
>>> waiting to happen.  The above is the only sane way to do it, and it
>>> isn't very hard to implement. ...
>>
>> except on Windows, where it is impossible to implement.
>
> True.  Although every program parses its own options on Windows, so
> proper, safe quoting is *also* impossible to implement.

Hmm, furthermore, perl seems to implement the "-|" operation just fine
on Windows.  I'm not really sure what it does, but it works.  Try the
attached perl script with the following command sequence.  (It works
on cygwin bash, but that might be magic; try it from cmd.exe instead
if you really want to reassure yourself.)

    echo >"foo blah"
    dir foo blah
         # above gives an error
    dir "foo blah"
         # above works
    c:\perl\bin\perl test.pl cmd /c dir "foo blah"
         # above works

Tested with ActiveState perl 5.6.1 (fails as "-|" is apparently not
supported *at all*, but maybe that's only on Windows), Cygwin perl
5.8.8 (works fine), and msysgit's perl 5.8.8 (works fine).

Now, as you can see above, the only copy of perl 5.6.x that I have
*didn't* work with this test, but it's on Windows, where I suspect
that version is just broken.  It says:

   '-' is not recognized as an internal or external command, operable
program or batch file.

You might then suspect that perhaps perl 5.6.1 didn't support the
open($fh, "-|") syntax at all, but 'perldoc perlipc' even on my
ActiveState perl 5.6.1 documents the feature.  Thus, I think it's
*just* the (obsolete) ActiveState version on Windows that has a buggy
implementation.  I would appreciate if someone with perl 5.6 on Linux
could try the program below with the commands above and see if it
works.

As another side note, the ActiveState perl *does* work if you call
fork() instead of open($fh, "-|"), but of course that doesn't redirect
stdin/stdout of the called process.  So perl on Windows *does*
correctly fake the fork/exec part.

test.pl follows.

Have fun,

Avery

P.S. Congratulations to the msysgit people for providing the only
version of msys perl that I could figure out how to install.


#!/usr/bin/perl -w
use strict;

if (@ARGV < 1) {
    print STDERR "Usage: $0 <command line...>\n";
    exit 127;
}

print "Arguments:\n{", join("}\n{", @ARGV), "}\n\n";

my $pid = open my $fh, "-|";
if ($pid) {
    # parent
    while (<$fh>) {
        s/\r?\n$//;
        chomp;
        print "[$_]\n";
    }
    my $newpid = waitpid($pid, 0);
    if ($newpid != $pid) {
        die("waitpid returned '$newpid', expected '$pid'\n");
    }	
    my $ret = $?;
    exit $? >> 8;
} else {
    # child
    exec(@ARGV);
}

# NOTREACHED
