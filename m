From: Pierre-Olivier Vares <pierre-olivier.vares@fingerprint.fr>
Subject: Internationalization and yes/no prompts
Date: Mon, 23 Feb 2015 16:46:07 +0100
Message-ID: <54EB4B3F.6080706@fingerprint.fr>
References: <20150212085211.9112780692@smtp-out.fingerprint.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 16:46:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPvD6-0002Xy-00
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 16:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbbBWPqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 10:46:11 -0500
Received: from smtp-out.fingerprint.fr ([109.69.192.220]:57353 "EHLO
	smtp-out.fingerprint.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbbBWPqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 10:46:10 -0500
Received: from mxr1.fingerprint.fr (unknown [192.168.2.144])
	by smtp-out.fingerprint.fr (Postfix) with SMTP id 406C380A90
	for <git@vger.kernel.org>; Mon, 23 Feb 2015 16:41:39 +0100 (CET)
Received: (qmail 8860 invoked from network); 23 Feb 2015 15:46:07 -0000
Received: from unknown (HELO ?192.168.0.128?) (109.69.192.35)
  by mxr1.fingerprint.fr with SMTP; 23 Feb 2015 15:46:07 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150212085211.9112780692@smtp-out.fingerprint.fr>
X-Forwarded-Message-Id: <20150212085211.9112780692@smtp-out.fingerprint.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264266>

Hi,

I just fell in a little trap, in which you may find interest.

I'm using git on the command line (on an Elementary OS system : Linux 
3.2.0-76-generic #111-Ubuntu SMP Tue Jan 13 22:16:09 UTC 2015 x86_64 
x86_64 x86_64 GNU/Linux).
git version : 2.3.0

My system is configured in french.

That's said :
I run a git clean -i, and select option 4 (ask each).
     (By the fact, messages are translated, but options of the 
'interactive' menu aren't)
So I get, for each file, the question :
/Supprimer //premier_fichier ? [Remove first_file ?]/
Natural answer to this question is 'Oui' [Yes], so I type 'o', rather 
than 'y'.
Once finished, I see no file has been removed (since 'o' has been 
considered as 'different than yes')
Whereas it's not an end-of-the-world thing*, it's annoying as at first 
sight I didn't understand why it has 'not worked'.

I thought of a few possibilities (some easy to implement, others more 
complex; some are stricter for the user) :
- explicitly put "y/n" in the message. Translaters should be warned to 
let "y/n",
- only allow y and n answers (and variants : yes, no), and reject 
everything else with a message
- use as 'n', but echoes a message : 'Answer considered as /no/'
- accept answers depending on the language used to echo the prompt (y/n 
for english, o/n for french, j/n for german, ...)

What do you think about that ?

* but just imagine how worst it could be if you're configured in a 
language where 'No' is said using a word beginning by 'Y'...

Cheers,
Pierre-Olivier Vares
