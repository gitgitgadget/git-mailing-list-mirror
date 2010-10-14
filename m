From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Thu, 14 Oct 2010 11:31:10 -0700
Message-ID: <4CB74C6E.5070009@gmail.com>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <4CB0BFDB.7010503@web.de> <4CB5C6D8.1070108@xiplink.com> <4CB6093F.3040800@web.de> <1691DBFD-6075-479E-8847-EB4595BB9E10@sb.org> <4CB61137.6030502@web.de> <4CB65650.6080204@gmail.com> <4CB7489A.60903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 14 20:30:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6SZn-0006FP-2o
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 20:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab0JNSaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 14:30:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42793 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791Ab0JNSap (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 14:30:45 -0400
Received: by pvc7 with SMTP id 7so608810pvc.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=NKLDLTTVSD0cgFae0YHVywfJDBnpLFVSv5gyA+FPekU=;
        b=VgRYC09JWmqjj4sCEBJ8yQu/J7/ju6ZkP52waQZja5ezGKeYTHiAei5fgnfFND6ueh
         XcETh3hbT1mWzbhY0GByiwTXpn1OssmLoovwbO0NupG+jVoxQ0WIj0ALBrTvoj3kUzoX
         AvJm9VY/4kOseaXYElpNxFVFeW4nHt4lB5WIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Gt31T6cTJ3XNNAal4DLsMZmOy3BSyHCZvQeY/ycAV02fnup9yZgwWNXrfYOgSj0CwB
         tJWU7d4uYW3nk52U7ZE2rdj3p9Adp0GOI0fMN0F0sEjdbH66sK3VPQh/LJoAcUZ7Otqd
         adem9rcwPlI5U1nnCM0ND1mEqix++57X0gffo=
Received: by 10.142.103.10 with SMTP id a10mr9182799wfc.116.1287081045112;
        Thu, 14 Oct 2010 11:30:45 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id x18sm3477459wfa.23.2010.10.14.11.30.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 11:30:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.12) Gecko/20100914 SUSE/3.0.8 Thunderbird/3.0.8
In-Reply-To: <4CB7489A.60903@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159064>

On 14/10/10 11:14, Jens Lehmann wrote:
> Am 14.10.2010 03:01, schrieb Chris Packham:
>> For modules they are working on they to rebase their working branch to
>> the SHA1 recorded in the superproject. I think this kind of thing has
>> already been discussed on the list, not sure that I've seen a solution
>> that would work for us. For now all of this is is wrapped in a script
>> for the developers.
> 
> I assume you know the "--rebase" option and the "update=rebase" config
> setting for "git submodule update" and they don't work for you?
>

That's news to me. Our most of our developers are running git 1.6.3 so
it won't work for them. I'll start changing our scripts to at least set
that variable in preparation for our next update (probably won't be for
a while). I can test it out on my PC and see if it suits our workflow.

> 
>> Developers would probably want the fetch-if-super-gitlink-has-changed
>> behaviour.
> 
> Yeah, I think we need to support the fetch-if-super-gitlink-has-changed,
> always-fetch-all and never-fetch behavior. So in your example you could
> set fetch-if-super-gitlink-has-changed in the global config and use
> fetch-all for the submodule you are hacking on by changing its config
> if you want that.
> 
> 
>> Hope that is a useful use-case.
> 
> Sure, thanks!
