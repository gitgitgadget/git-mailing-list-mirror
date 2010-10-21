From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH v2] blame: Add option to show author email instead of name
Date: Thu, 21 Oct 2010 13:28:57 -0700
Message-ID: <79AB0864-E151-468E-9C86-EBCAD929938B@sb.org>
References: <7vsk02ypj5.fsf@alter.siamese.dyndns.org> <1287535323-20347-1-git-send-email-kevin@sb.org> <20101021180525.GA11501@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:29:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91l5-0003FK-Im
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab0JUU3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:29:01 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50290 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab0JUU3A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 16:29:00 -0400
Received: by pxi12 with SMTP id 12so5832pxi.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:29:00 -0700 (PDT)
Received: by 10.142.212.20 with SMTP id k20mr1352908wfg.132.1287692940081;
        Thu, 21 Oct 2010 13:29:00 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w14sm3008598wfd.6.2010.10.21.13.28.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 13:28:58 -0700 (PDT)
In-Reply-To: <20101021180525.GA11501@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159559>

On Oct 21, 2010, at 11:05 AM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
> 
>> +++ b/t/t8002-blame.sh
>> @@ -6,4 +6,9 @@ test_description='git blame'
>> PROG='git blame -c'
>> . "$TEST_DIRECTORY"/annotate-tests.sh
>> 
>> +PROG='git blame -c -e'
>> +test_expect_success 'Blame --show-email works' '
>> +    check_count "<A@test.git>" 1 "<B@test.git>" 1 "<B1@test.git>" 1 "<B2@test.git>" 1 "<author@example.com>" 1 "<C@test.git>" 1 "<D@test.git>" 1
>> +'
>> +
> 
> Bonus nit: does this belong in annotate-tests.sh or does it only apply
> to "git blame" and not "git annotate"?  If the latter, a note in the
> commit message would be helpful.

--show-email originally only applied to git-blame. I tweaked the patch to make it apply to git-annotate simply because check_count can't handle the format of git-blame, but the intention of the change wasn't to make it apply to git-annotate in the first place. You'll note I also didn't document it in the manpage for git-annotate. If you think it's better to move it into annotate-tests.sh, I can do that, but that does mean officially declaring git-annotate as supporting --show-email.

-Kevin Ballard