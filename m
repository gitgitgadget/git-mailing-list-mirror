From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make guilt work even after git-sh-setup is moved out
 of the user's path
Date: Mon, 07 Jul 2008 17:56:54 -0700
Message-ID: <7vwsjxxkfd.fsf@gitster.siamese.dyndns.org>
References: <1215475392-26221-1-git-send-email-tytso@mit.edu>
 <1215475392-26221-2-git-send-email-tytso@mit.edu>
 <1215475392-26221-3-git-send-email-tytso@mit.edu>
 <20080708003256.GB1880@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Ts'o" <tytso@MIT.EDU>, git@vger.kernel.org
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 02:58:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG1Wu-0001OZ-Jo
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 02:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105AbYGHA5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 20:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755082AbYGHA5G
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 20:57:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbYGHA5E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 20:57:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A4EF26F26;
	Mon,  7 Jul 2008 20:57:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C015326F25; Mon,  7 Jul 2008 20:56:58 -0400 (EDT)
In-Reply-To: <20080708003256.GB1880@josefsipek.net> (Josef Sipek's message of
 "Mon, 7 Jul 2008 20:32:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C6D68786-4C88-11DD-8642-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87675>

"Josef 'Jeff' Sipek" <jeffpc@josefsipek.net> writes:

> On Mon, Jul 07, 2008 at 08:03:12PM -0400, Theodore Ts'o wrote:
>> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
>> ---
>>  guilt |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/guilt b/guilt
>> index cdf4e9b..d30d35a 100755
>> --- a/guilt
>> +++ b/guilt
>> @@ -23,7 +23,7 @@ esac
>>  # we change directories ourselves
>>  SUBDIRECTORY_OK=1
>>  
>> -. git-sh-setup
>> +. $(git --exec-path)/git-sh-setup
>
> This seems wrong.
>
> jeffpc@freyr:~$ git --version
> git version 1.5.6.2.247.g923712
> jeffpc@freyr:~$ git --exec-path
> /home/jeffpc/git-bin/bin

Hmm, it is yours that look wrong.

With 1.6.0 preview (aka 'master'):

$ git --version
git version 1.5.6.2.255.gbed62
$ git --exec-path
/home/junio/git-master/libexec/git-core

With 1.5.6 maintenance track (aka 'maint'):

$ ~/git-maint/bin/git --version
git version 1.5.6.2.15.g39f31
$ ~/git-maint/bin/git --exec-path
/home/junio/git-maint/bin
