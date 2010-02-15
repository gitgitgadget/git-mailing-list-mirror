From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [PATCH] require_work_tree broken with NONGIT_OK
Date: Mon, 15 Feb 2010 10:14:30 -0500
Message-ID: <4B7964D6.1030403@gmail.com>
References: <4B78C4D3.90407@gmail.com> <7vzl3bj95l.fsf@alter.siamese.dyndns.org> <20100215074922.GA5549@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 16:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh2fZ-0007gw-C6
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 16:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755250Ab0BOPPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 10:15:23 -0500
Received: from mail-qy0-f200.google.com ([209.85.221.200]:63472 "EHLO
	mail-qy0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab0BOPPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 10:15:22 -0500
Received: by qyk38 with SMTP id 38so291655qyk.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 07:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=EnEV5StLouYWLCPsNbnnU3UmqGjDgEzfsBPa5Il+CpU=;
        b=ehGdeClu7NNjm1WjdLN55qlXwX45IdLEZNVGhpM/673LDIfVEy79zmpqv6VrdeuQaf
         GwqSWmAOvei83vF/eEZTF/ZOLtRmEJaTXzEtF0GdjHOepiivoU5BwR9WCcg5XmSiEK2C
         s2QUY7OY7xYQS7iUmcLueRDgOFMGiePq+43F8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=lxtbY5kf2cqrxfYT23EK61xu83cqnYq8iCN2gZ1ue3PwpEs5QfqYkcdzLZInAunvW7
         G0nNx/lpH3DEKfkP/Gxj37nzx/GQtvXuXpNdZpBuZ5nezKbEhir2A8gkEGwhCUfX6Im4
         2yCsFyGU18VmIv3B8RYTqRK31ZgVDjsSE5StM=
Received: by 10.229.111.81 with SMTP id r17mr2292886qcp.32.1266246919184;
        Mon, 15 Feb 2010 07:15:19 -0800 (PST)
Received: from ?10.145.1.205? (smtpin.revolutionlinux.com [69.70.10.188])
        by mx.google.com with ESMTPS id 20sm4310667qyk.9.2010.02.15.07.15.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 07:15:17 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <20100215074922.GA5549@coredump.intra.peff.net>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140013>

On 2010-02-15 02:49, Jeff King wrote:
> Thinking on this a bit more, I think Gabriel's script is a little
> broken. It sets NONGIT_OK to not have a git repository, but then it
> requires a working tree, which doesn't make any sense.
> 
I hit this bug while working on a script called git-bzr over at
http://github.com/kfish/git-bzr when trying to use git-sh-setup to avoid
reinventing the wheel.

Most commands in there need to be run inside a git repository and some
don't. I was trying find out how to implemnt "git bzr clone", which for
obvious reasons should not require a work tree..

plus, I thought requiring presence in a work tree to display help
messages was not a very user-friendly concept (this was git-bzr's
behaviour some days ago).

I'm thinking of changing things to use git-sh-setup by splitting the
script into non-work-tree-requiring commands in the main script and
commands requiring a work tree in another sub-script.

Well, all this to simply illustrate possible use cases.

I'll surely be opening another discussion about git-bzr pretty soon to
see if people would be interested in helping out.

thanks again to both of you.

-- 
Gabriel Filion
