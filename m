From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Wed, 23 Nov 2011 10:22:05 +0100
Message-ID: <4ECCBB3D.7070204@alum.mit.edu>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com> <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com> <4ECB315F.4080701@alum.mit.edu> <7vwrasdp3t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Gerd Knops <gerti@bitart.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 10:22:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT924-0006Vm-2P
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 10:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab1KWJWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 04:22:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51613 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab1KWJWL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 04:22:11 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAN9M5EA030135
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Nov 2011 10:22:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vwrasdp3t.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185833>

On 11/22/2011 06:49 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> Currently git handles references names case-sensitively and allows
>> multiple reference names that differ only in case.
> 
> We do the same for in-tree paths, by the way.  Ultimately, I think the
> sane thing to do is to appeal to the user's common sense.  [...common
> sense aka "if it hurts don't do it" omitted...]
> 
> I think refnames have exactly the same issue. In theory, you could have
> "Master" and "master" branches, and nothing stops you from trying to do
> so, but in practice, if it is not useful for you and your project, and
> if it is equally fine to use some other name instead of "Master" for the
> purpose of you and your project, then there is no strong reason for doing
> so, unless you are trying to irritate users on case folding platforms.

I agree.

But git could nevertheless help users (1) by providing config settings
or hook scripts or something that could be configured in a repository to
prevent case-conflicts from entering the project history; (2) by
emitting an error when such a conflict arises rather than getting so
confused.

Note that Unicode encoding differences can cause very similar problems
(even assuming utf8, there can be multiple ways to encode the same
string) and should maybe be addressed similarly.

By the way, I'm not volunteering for this project; case-sensitive
ASCII's good enough for me :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
