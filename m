From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intricacies of submodules
Date: Fri, 11 Apr 2008 15:32:14 -0700
Message-ID: <7vmyo0owep.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <1207859579.13123.306.camel@work.sfbay.sun.com>
 <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Roman Shaposhnik" <rvs@sun.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 00:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkRo0-00045Z-5h
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 00:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757105AbYDKWc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 18:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757088AbYDKWc2
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 18:32:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821AbYDKWc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 18:32:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56C4E1F7A;
	Fri, 11 Apr 2008 18:32:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6DAFB1F76; Fri, 11 Apr 2008 18:32:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79303>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Fri, Apr 11, 2008 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  > Some of it is personal, yes. But sometimes those personal preferences
>>  > need to be enforced on a project level (of course, giving everybody
>>  > a way to override the setting if they really want to). For a big
>>  > software organization with a mix of senior and junior engineers I need
>>  > a way to set up *my* workspace in such a way that everybody who
>>  > clones/pulls from it get not only the source code, but also "Git best
>>  > practices". That would simplify things a great deal for me, because
>>  > I can always say: "just pull my latest .gitconfig, make sure you
>>  > don't have any extra stuff in your .git/confing and everything
>>  > in Git will work for you".
>>
>>  I think the way you stated the above speaks for itself.  The issue you are
>>  solving is mostly human (social), and solution is majorly instruction with
>>  slight help from mechanism.  The instruction "Use this latest thing, do
>>  not have anything in .git/config" can be substituted with "Use this latest
>>  update-git-config.sh which mucks with your .git/config to conform to our
>>  project standard", without losing simplicity and with much enhanced
>>  robustness, as you can now enforce that the users do not have anything
>>  that would interfere with and countermand your policy you would want to
>>  implement.
>>
> But, how  to handle the case that  there are more than one policies
> for different projects?

"How to"?  You would handle the case just like either of us suggested
above.

Are you talking about a single project with more than one policies A, B,
C, ... that conflict with each other?  Or are you talking about more than
one projects, each of which has a single project-wide policy?

I do not think the former makes sense and won't be helped with in-tree
file that overrides .git/config Roman discussed either.

The latter would be helped equally well whether that in-tree polic file is
called .gitconfig or update-git-config.sh.
