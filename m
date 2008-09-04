From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Directory renames without breaking git log.
Date: Thu, 04 Sep 2008 12:49:27 -0700
Message-ID: <7vtzcv1yk8.fsf@gitster.siamese.dyndns.org>
References: <200809032338.35359.kai@samba.org>
 <905315640809031716j7d74d7a6m51b434f62b011135@mail.gmail.com>
 <200809042145.09573.kai@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kai Blin <kai@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:50:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbKqo-0002FL-MB
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280AbYIDTtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYIDTtg
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:49:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbYIDTtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:49:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E11A3734C0;
	Thu,  4 Sep 2008 15:49:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E97CB734BD; Thu,  4 Sep 2008 15:49:29 -0400 (EDT)
In-Reply-To: <200809042145.09573.kai@samba.org> (Kai Blin's message of "Thu,
 4 Sep 2008 21:45:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 99851ADA-7ABA-11DD-8AB9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94955>

Kai Blin <kai@samba.org> writes:

> On Thursday 04 September 2008 02:16:24 Tarmigan wrote:
>> On Wed, Sep 3, 2008 at 2:38 PM, Kai Blin <kai@samba.org> wrote:
>> > Unfortunately, the directories are big enough that git log stops to track
>> > the renamed files, so e.g. git log ./samba3 does not show the samba3
>> > history. The history is not lost, of course, but it's way less intuitive
>> > to get it.
>>
>> You can try setting diff.renamelimit to 0 in your ~/.gitconfig.  See
>> Linus's email here for a similar situation in the kernel:
>> http://lwn.net/Articles/292948/
>
> That doesn't seem to fix "git log path/to/file" cases. The really interesting 
> part is that if I try git log --follow -M -C path/to/file, I don't get any 
> history at all. (--follow is the culprit, if I remove that I at least get the 
> merge commit)
>
> git blame still works, and git log --sparse path/to/file works, of 
> course. --sparse makes giving a path a bit pointless, of course, but we 
> probably can live with that for time being. I'm still open for suggestions, 
> of course. :)

Give both directories, like:

	"git log -- newdir olddir"

perhaps?
