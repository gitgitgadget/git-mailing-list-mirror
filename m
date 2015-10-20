From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git-p4 fails with NameError with python 2.7.2
Date: Tue, 20 Oct 2015 09:00:27 -0700
Message-ID: <xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>
	<CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Etienne Girard <etienne.g.girard@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:00:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoZL5-0007WP-By
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 18:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbbJTQAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 12:00:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34755 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbJTQA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 12:00:29 -0400
Received: by padhk11 with SMTP id hk11so25330884pad.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4hKVprUaFU+bcVVI14rUYXTELWxrg77XWL9JMN1DP14=;
        b=DdJgrfYHZVR9gAfV8JDHwJ9Rbh9bqqaRjytXG7G4J6A48mJNU786pKR7mltEWUdkcy
         lFOPuhfD5KCe8mp7Qj3EJLQ8C52cnL6hJGLJ/sdUALZ7Ubwk5R+n5RrRMgGXFCY/2TY+
         AsuE6IXu6jOpFH7656VEEtKOYp0r2/HutPkY3CXMdlY3xJu3Uy4hlmxeSDRDh1aSkfD0
         vbmzuXVLDp7APkxDM6/ZgTcMWaX9tPv4m+CIg47hyUcXsMcMM2x/8A7uIcKuqJqGhXiY
         MtBiaB1tMFu3ERTJQd+oUeogIih3uN/lmIhl3T9Zit2n50GFjEDGIWzRoxv++wdxrHeH
         E9mw==
X-Received: by 10.68.168.97 with SMTP id zv1mr4880644pbb.86.1445356828800;
        Tue, 20 Oct 2015 09:00:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id yg2sm4495924pbb.79.2015.10.20.09.00.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 09:00:28 -0700 (PDT)
In-Reply-To: <CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>
	(Luke Diamand's message of "Tue, 20 Oct 2015 14:57:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279919>

Luke Diamand <luke@diamand.org> writes:

> On 20 October 2015 at 11:34, Etienne Girard <etienne.g.girard@gmail.com> wrote:
>> Hello,
>>
>> Git-p4 fail when I try to rebase with the error: "NameError: global
>> name 'ctypes' is not defined". The error occurs when I use python
>> 2.7.2 that is installed by default on my company's computers (it goes
>> without saying that everything works fine with python 2.7.10).
>>
>> I'm a beginner in python, but simply importing ctypes at the beginning
>> of the script does the trick. I was wondering if submitting a patch
>> for this issue is worth the trouble, when a satisfying solution is not
>> using a 4 years old version of python.
>
> If you're able to submit a patch that would be great!

Lars's 4d25dc44 (git-p4: check free space during streaming,
2015-09-26) introduced two references to ctypes.* and there is no
'import ctypes' anywhere in the script.

I do not follow Python development, but does the above mean that
with recent 2.x you can say ctypes without first saying "import
ctypes"?  It feels somewhat non-pythonesque that identifiers like
this is given to you without you asking with an explicit 'import',
so I am puzzled.
