From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 11:28:13 -0700
Message-ID: <7vabct3l1e.fsf@gitster.siamese.dyndns.org>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>
 <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>
 <m38wsei8ne.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 20:29:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtRPs-0003jC-JQ
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 20:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbYJXS2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 14:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbYJXS2c
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 14:28:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbYJXS2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 14:28:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F055273CB0;
	Fri, 24 Oct 2008 14:28:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A970D73CAF; Fri, 24 Oct 2008 14:28:21 -0400 (EDT)
In-Reply-To: <m38wsei8ne.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Fri, 24 Oct 2008 03:31:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8DD8E80E-A1F9-11DD-A90E-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99049>

Jakub Narebski <jnareb@gmail.com> writes:

> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>> On Fri, Oct 24, 2008 at 1:23 AM, Jean-Luc Herren <jlh@gmx.ch> wrote:
>
>> > If you decide against a shared repository, maybe you want to
>> > consider to not use ".zit.file/", but ".zit/file/" as the
>> > repository?  This would reduce the clutter to a single directory,
>> > just like with ".git".  And moving files around wouldn't be that
>> > much complicated.
>> 
>> Right. I'll give that a shot.
>
> By the way RCS which I use for version control of single files use
> both approaches: it can store 'file,v' alongside 'file' (just like
> your '.zit.file/' or '.file.git/'), but it can also store files on
> per-directory basis in 'RCS/' subdirectory (proposed '.zit/file/' or
> '.zit/file.git/' solution)

I am not opposed to the wish to track a single file (but I have to say I
am not personally in need for such a feature), but I have to wonder from
the technical point of view if one-repo-per-file is the right approach.

Running "git init" in an empty directory consumes about 100k of diskspace
on the machine I am typing this on, and you should be able to share most
of them (except one 41-byte file that is the branch tip ref) when you
track many files inside a single directory by using a single repository,
one branch per file (or "one set of branches per file") model.
