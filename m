From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] config: Add hashtable for config parsing & retrieval
Date: Mon, 16 Jun 2014 19:35:35 +0200
Message-ID: <vpqlhswzriw.fsf@anie.imag.fr>
References: <1402907232-24629-1-git-send-email-tanayabh@gmail.com>
	<1402907232-24629-3-git-send-email-tanayabh@gmail.com>
	<vpqy4ww230l.fsf@anie.imag.fr> <539F293D.9000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 19:35:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwaoq-0002sp-Ll
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 19:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbaFPRfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 13:35:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46739 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbaFPRfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 13:35:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5GHZXU8015172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jun 2014 19:35:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5GHZZlB026712;
	Mon, 16 Jun 2014 19:35:35 +0200
In-Reply-To: <539F293D.9000602@gmail.com> (Tanay Abhra's message of "Mon, 16
	Jun 2014 10:28:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jun 2014 19:35:33 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251738>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 06/16/2014 10:11 AM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> Add a hash table to cache all key-value pairs read from config files
>>> (repo specific .git/config, user wide ~/.gitconfig and the global
>>> /etc/gitconfig). Add two external functions `git_config_get_string` and
>>> `git_config_get_string_multi` for querying in a non-callback manner from the
>>> hash table.
>> 
>> This describes rather well _what_ your patch does, but the most
>> important part of a commit message is to justify _why_ the change is
>> good, and why the way you implemented it is good.
>> 
>> Think of it as an way to convince reviewers to accept your patch.
>
> Okay, but isn't the content of the cover letter is doing that for now.

The cover letter won't be part of the Git history, while the commit
messages are.

Imagine someone finding your functions in the code and wondering "wtf
is this code doing here?". "git blame" will point this person to your
commit message, but digging the mail archives is one big extra step
(that essentially no one will make).

> Yeah, I have run the experiments. I will add a test file for it. I should have
> appended it to this series only, my fault. :) A stray observation, Git has very less
> unit tests, compared to the comprehensive test directory for commands.

Yes. But in most cases, code written in a commit is directly reachable
from the command-line UI, and can be tested this way.

(I do believe that Git would benefit from more unit-testing, but that's
another topic).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
