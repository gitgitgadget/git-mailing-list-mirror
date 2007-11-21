From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitview: revamped to use string.join, stripped a function def
Date: Tue, 20 Nov 2007 22:50:37 -0800
Message-ID: <7vfxz0hz2a.fsf@gitster.siamese.dyndns.org>
References: <1190922917-5044-1-git-send-email-crquan@gmail.com>
	<91b13c310711202119j4f9e20f0n2515babe5f9217ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org,
	cr_quan@163.com, "Scott James Remnant" <scott@ubuntu.com>
To: "rae l" <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 07:51:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujQQ-0004wT-Fe
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 07:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbXKUGut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 01:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbXKUGut
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 01:50:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55645 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbXKUGut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 01:50:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 09B362EF;
	Wed, 21 Nov 2007 01:51:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 781D5962CC;
	Wed, 21 Nov 2007 01:51:02 -0500 (EST)
In-Reply-To: <91b13c310711202119j4f9e20f0n2515babe5f9217ac@mail.gmail.com>
	(rae l.'s message of "Wed, 21 Nov 2007 13:19:30 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65601>

"rae l" <crquan@gmail.com> writes:

> Please give some comments.
>
> On Sep 28, 2007 3:55 AM, Denis Cheng <crquan@gmail.com> wrote:
>> Signed-off-by: Denis Cheng <crquan@gmail.com>

Blast from the past ;-).

>> -def list_to_string(args, skip):
>> -       count = len(args)
>> -       i = skip
>> -       str_arg=" "
>> -       while (i < count ):
>> -               str_arg = str_arg + args[i]
>> -               str_arg = str_arg + " "
>> -               i = i+1
>> -
>> -       return str_arg
>> ... 
>>                 """Fill in different windows with info from the reposiroty"""
>> -               fp = os.popen("git rev-parse --sq --default HEAD " + list_to_string(args, 1))
>> +               fp = os.popen("git rev-parse --sq --default HEAD " + " ".join(args[1:]))

Obviously correct, loses extra SPs on both ends of the args
string, and reads more Pythonic.
