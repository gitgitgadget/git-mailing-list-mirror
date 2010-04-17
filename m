From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Sat, 17 Apr 2010 15:02:39 +0200
Message-ID: <201004171502.42044.jnareb@gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <201004151107.33892.jnareb@gmail.com> <20100417095259.GA23110@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 15:02:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O37fn-0006oq-DH
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 15:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab0DQNCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 09:02:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:2862 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab0DQNCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 09:02:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so887753fgg.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vDB3LgtnpBXT+sZlbrNuddcfmb07djAsvsuQRxiu8rY=;
        b=B8rxte/zbhxm9bRRh0tihubtCKx6VrJF1NgEeyCOzpzP2ZoMLz3qwiNS58Lr+2dzUV
         PthsUfPFrtSAWhOaPg1U+6xeob8HI8xDXsoHFbrMJqPw9tWUg6welcs4f3+EDwIGFeUO
         kdgX3+9L2oocdMsbRtqRiRZrIt7fQnMs81cx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CUmweETkL4sQRR/p1ByEXYjeqMgwjGg203gqFLXFEWmcxQojmLV/zJMeqETP2JKedH
         uVJ+u2lPcLQwYa3YYFDNdAo7IRbqhO0lth9jRw9JX24LFqTFvqS9uAQ2i3FIBVP2HQCQ
         zp3KI/Yk3jb5ShfyNDYQ+GeVsQHAiEKALAVgA=
Received: by 10.223.92.155 with SMTP id r27mr1366917fam.7.1271509370810;
        Sat, 17 Apr 2010 06:02:50 -0700 (PDT)
Received: from [192.168.1.13] (abvc197.neoplus.adsl.tpnet.pl [83.8.200.197])
        by mx.google.com with ESMTPS id 35sm6126375fkt.37.2010.04.17.06.02.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 06:02:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100417095259.GA23110@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145146>

On Sat, 17 Apr 2010, Jeff King wrote:
> On Thu, Apr 15, 2010 at 11:07:32AM +0200, Jakub Narebski wrote:

> > [1] A question: we have working area version, index version, and HEAD
> >     version of file.  Isn't it possible for *each* of them to have 
> >     different filename?  What about the case of rename/rename merge
> >     conflict?

[cut]

Thanks for detailed explanation.

> > Although if possible I'd like to have it wrapped in utility macros,
> > like parseopt, so one does not need to write output_str / output_int
> > etc.... but currently it is very, very vague sketch of an idea, rather
> > than realized concept.
> 
> I'm not sure I understand what utility macros you would want.

Something like that (please remember that it is still in vague beginnings
of an idea stage:

  OUT_OBJECT(
     OUT_FIELD("mode",   OUT_MODE, tree.mode), SP,
     OUT_FIELD("type",   "%s", tree.object.type), SP,
     OUT_FIELD("object", OUT_SHA1, tree.object.sha1), TAB,
     OUT_FIELD("file", OUT_FILE(sep), tree.filename), 
     sep
  );

-- 
Jakub Narebski
Poland
