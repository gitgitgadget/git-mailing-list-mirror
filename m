From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules too
Date: Wed, 13 Oct 2010 14:31:05 -0700
Message-ID: <5CEA6C62-551A-4CB2-847B-A008102830A6@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <4CB0BFDB.7010503@web.de> <4CB5C6D8.1070108@xiplink.com> <4CB6093F.3040800@web.de> <1691DBFD-6075-479E-8847-EB4595BB9E10@sb.org> <4CB62434.3070204@xiplink.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:31:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P68vK-0005zB-D5
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab0JMVbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:31:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55283 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab0JMVbK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 17:31:10 -0400
Received: by pxi16 with SMTP id 16so852862pxi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 14:31:09 -0700 (PDT)
Received: by 10.142.12.13 with SMTP id 13mr8047522wfl.393.1287005469822;
        Wed, 13 Oct 2010 14:31:09 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm1595694wfa.11.2010.10.13.14.31.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 14:31:07 -0700 (PDT)
In-Reply-To: <4CB62434.3070204@xiplink.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158979>

On Oct 13, 2010, at 2:27 PM, Marc Branchaud wrote:

>> I'm not sure it's correct though. For example, with my scenario every
>> single submodule is required for a correct build, but most submodules
>> should definitely not be updated unless their parent submodule updates its
>> gitlink. So --recursive is recommended for `git clone`, but a
>> non-recursive fetch would be the correct behavior going forward.
> 
> What about a "smart" recursive fetch?  One where if *any* new ref in the
> superproject changes the superproject's submodule ref, *and* that submodule
> ref isn't already in the submodule repo, then fetch updates the submodule.
> Recurse as needed.
> 
> That way I don't think there'd be any missing commits when checking out
> different branches in the superproject, and submodule fetches are minimized.
> 
> Not sure how easy that would be to implement though, or what the performance
> would be like.

That was actually my original recommendation. I've since backed away from it, due to concerns about difficulty in implementation, but if it can be done then this would be rather ideal for most common cases.

-Kevin Ballard