From: David Kastrup <dak@gnu.org>
Subject: Re: Creating own hierarchies under $GITDIR/refs ?
Date: Sun, 02 Feb 2014 13:09:52 +0100
Message-ID: <87sis1zpf3.fsf@fencepost.gnu.org>
References: <87a9e92424.fsf@fencepost.gnu.org>
	<CACsJy8CdKRQ_au3QqVoUdedvPpkPh_2vodKJwLZ7VrrwRJSDXQ@mail.gmail.com>
	<8761ox2240.fsf@fencepost.gnu.org>
	<CACsJy8A44EoxEb3b=ZZ-jgLLtn1ttr0P8gGwWJ2dNYCWi3MRUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 13:10:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9vsY-0001en-KV
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 13:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbaBBMKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 07:10:18 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:57278 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbaBBMJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 07:09:54 -0500
Received: from localhost ([127.0.0.1]:56320 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W9vs1-000688-9q; Sun, 02 Feb 2014 07:09:53 -0500
Received: by lola (Postfix, from userid 1000)
	id E09C1DF68C; Sun,  2 Feb 2014 13:09:52 +0100 (CET)
In-Reply-To: <CACsJy8A44EoxEb3b=ZZ-jgLLtn1ttr0P8gGwWJ2dNYCWi3MRUw@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 2 Feb 2014 19:00:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241368>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 2, 2014 at 6:19 PM, David Kastrup <dak@gnu.org> wrote:
>> Since Git has a working facility for references that is catered to do
>> exactly this kind of mapping and already _does_, it seems like a
>> convenient path to explore.
>
> It will not scale. If you make those refs available for
> cloning/fetching, all of them will be advertised first thing when git
> starts negotiate. Imagine thousands of refs (and keep increasing) sent
> to the receiver at the beginning of every connection.

In current LilyPond repository:
git tag|wc
    969     969   15161

In current Emacs mirror:
git tag|wc
   1202    1202   15729

In current Git repository:
git tag|wc
    498     498    4820

> Something like "reverse git-notes" may transfer more efficiently. Or
> we need to improve git protocol to handle massive refs better,
> something that's been discussed for a while without any outcome.

I think that even disregarding special use of references, _existing_
practice would already appear to warrant being able to deal with
thousands of refs in a reasonable manner.

It's a reasonable expectation to have a tag per (potentially
intermediate) release or release candidate.  For any project publishing
reproducible daily snapshots, the threshold of 1000 will get reached
within few years.

Of course, it is relevant information to know that right _now_
references will not scale.  But that does not seem like a defensible
long-term perspective.

-- 
David Kastrup
