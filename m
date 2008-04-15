From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Finding changes in one branch not in two other branch
Date: Tue, 15 Apr 2008 12:05:50 -0700
Message-ID: <7viqyjx7jl.fsf@gitster.siamese.dyndns.org>
References: <cc723f590804150421j689ef4b1o57b97c937e23db99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 21:09:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlqUV-0006BU-0v
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 21:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYDOTGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 15:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbYDOTGF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 15:06:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbYDOTGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 15:06:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2663D31ED;
	Tue, 15 Apr 2008 15:06:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6417B31EB; Tue, 15 Apr 2008 15:05:57 -0400 (EDT)
In-Reply-To: <cc723f590804150421j689ef4b1o57b97c937e23db99@mail.gmail.com>
 (Aneesh Kumar's message of "Tue, 15 Apr 2008 16:51:59 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79620>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> To show a workflow:
>
> kernel releases 2.6.20 and the project release patchset on top of 2.6.20
> kernel release 2.6.21 and project release patchset on top of 2.6.21
>
> The second release involve some bug fixes for the project.
>
> The intention is to find out what changed in project with the release of
> 2.6.21 patchset

That depends on your definition of what a patchset is.

If it is a set of files, each file has a patch to one or more files to
implement a logically independent and complete change (i.e. corresponds to
what a commit should be), then you can run git-patch-id on each of them to
find the duplicates in these two sets (you do not need a git repository to
do this, as patch-id is a freestanding operation).

If you mean a single file that contains the difference between the vanilla
2.6.21 and their version, then you cannot do much better than running
interdiff, I'd guess.
 
