From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] request-pull: do something if $3 is passed
Date: Tue, 17 Feb 2015 16:10:08 -0500 (EST)
Message-ID: <1957798859.18730760.1424207408147.JavaMail.zimbra@redhat.com>
References: <1424110568-29479-1-git-send-email-bonzini@gnu.org> <xmqqiof163kk.fsf@gitster.dls.corp.google.com> <54E31405.5040502@gnu.org> <xmqqvbj01fbz.fsf@gitster.dls.corp.google.com> <54E3A5E2.6060806@gnu.org> <CA+55aFw_pKtraqwMMsqsYgF=ikShH=6ybtb7+QPr8r=77kmoVQ@mail.gmail.com> <54E3AA41.5070209@gnu.org> <CA+55aFxdxzeHmckgn5ZSvXKr9VOztNApif+=5xmZ+4v=RhUryQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 22:10:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNpPU-00015Y-WD
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 22:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbbBQVKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 16:10:14 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:46112 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbBQVKN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 16:10:13 -0500
Received: from zmail13.collab.prod.int.phx2.redhat.com (zmail13.collab.prod.int.phx2.redhat.com [10.5.83.15])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t1HLA8io047740;
	Tue, 17 Feb 2015 16:10:08 -0500
In-Reply-To: <CA+55aFxdxzeHmckgn5ZSvXKr9VOztNApif+=5xmZ+4v=RhUryQ@mail.gmail.com>
X-Originating-IP: [10.5.82.12]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF35 (Linux)/8.0.6_GA_5922)
Thread-Topic: request-pull: do something if $3 is passed
Thread-Index: K/HuJL2kI9lI8l5GXr0BvFUWj9+hGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263987>


> Looking for HEAD in "git ls-remote"? Perfectly sensible:
> 
>     [torvalds@i7 linux]$ git ls-remote origin | grep HEAD
>     cc4f9c2a91b7be7b3590bb1cbe8148873556aa3f HEAD
> 
> that's the default thing when you don't specify any particular branch or tag.

Sure.  But if I got a pull request saying "please pull
git://example.org/foo.git HEAD" I would think that the sender
messed up the pull request.  So *in the context of git-request-pull*
${remote:-HEAD} makes little sense to me.

But hey, you said it's me who makes no sense.  Maybe I really don't.

> The thing is, HEAD works. Not for you, because you don't use HEAD. But
> because you don't use HEAD, you shouldn't use the default.

Oki.  Will adjust my scripts.  Junio, you may still want to apply patch
1 if only for documentation purposes (the "tag foo" functionality is
unused in the rest of the test).

Paolo
