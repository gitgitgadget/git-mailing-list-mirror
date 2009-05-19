From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Convert hash functions to char instead of struct object
Date: Tue, 19 May 2009 00:04:18 -0700
Message-ID: <7vk54d8tfx.fsf@alter.siamese.dyndns.org>
References: <449c10960905182132h2c1b38b4jd28721adaeb38484@mail.gmail.com>
	<1242707644-29893-1-git-send-email-dpmcgee@gmail.com>
	<1242707644-29893-2-git-send-email-dpmcgee@gmail.com>
	<4A12507A.3050307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan McGee <dpmcgee@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 19 09:14:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6JWV-00050x-Aw
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 09:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbZESHNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 03:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZESHNy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 03:13:54 -0400
Received: from fed1rmmtai109.cox.net ([68.230.241.51]:50967 "EHLO
	fed1rmmtai109.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZESHNy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 03:13:54 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090519070419.BLMA2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Tue, 19 May 2009 03:04:19 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id tK4J1b0054aMwMQ04K4J0j; Tue, 19 May 2009 03:04:18 -0400
X-Authority-Analysis: v=1.0 c=1 a=0aA7sQqUqVEA:10 a=9g9rV6vYGpAA:10
 a=fv-XvKvnAAAA:8 a=BxqranHHwmWsJRS7eukA:9 a=RQ9ax241BT-oLD4KNmqDovlpDuQA:4
 a=l9rlz7MJbUIA:10
X-CM-Score: 0.00
In-Reply-To: <4A12507A.3050307@viscovery.net> (Johannes Sixt's message of "Tue\, 19 May 2009 08\:23\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119497>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Dan McGee schrieb:
>> -static unsigned int hash_obj(struct object *obj, unsigned int n)
>> +static unsigned int hash_chars(const unsigned char *c, unsigned int n)
>
> hash_chars suggests that this function hashes arbitrary character
> sequences, but it doesn't do that. Wouldn't hash_object_id be a better
> name? (And the parameter would then obviously be named sha1 or id.)

Yes, the parameter to this function is what we call "unsigned char *sha1"
everywhere else in the code.  hash-object-id or hash-object-name is a good
name for the function.
