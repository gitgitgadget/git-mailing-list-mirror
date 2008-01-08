From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 08 Jan 2008 12:20:36 +0000
Message-ID: <C3A91B14.10B40%jefferis@gmail.com>
References: <20080108100818.GA17205@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 13:21:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCDS7-0007yq-4L
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 13:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbYAHMUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 07:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbYAHMUm
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 07:20:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:38476 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYAHMUk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 07:20:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3287345ugc.16
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 04:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=vUDMqJZr9lKMCJXzjT130UU3LguEtVAt8vr4flKr8As=;
        b=pn2fp8F7j0WsGy3+Zj8qLEVLzAcGBWH1nPBG2n4XCs0JO+Tu4HknaCwEq1eDqxBT7aao5gmkx9oMxeaf+TsLKDbO78borNcoB/brBMbibk1uHMqH4r9E8Ry61WRmy0uvj6dOzMUCPnx0Ogp1inZzjIg3/r7KznOGZajnCzEyGik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=dTL/MiUf0pMnmkyBGlxKvAPC+eYTDVPqGUrjMbo3iSLgZ3arOnq2Dr4K4IM6AKMxwtHxD4mpWWn8TbY5k53w850NxRKyS95M3OPfEK/0nLsAgsRlxcKoyEAi9ef30nEBck+Gd6PwVhekJ/vxiGiIGsQ77eCvyvs7p5quIF7yr7g=
Received: by 10.67.20.19 with SMTP id x19mr658604ugi.48.1199794838555;
        Tue, 08 Jan 2008 04:20:38 -0800 (PST)
Received: from ?81.98.250.69? ( [81.98.250.69])
        by mx.google.com with ESMTPS id l20sm679700uga.62.2008.01.08.04.20.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2008 04:20:37 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: CRLF problems with Git on Win32
Thread-Index: AchR8N9GHdOP373kEdyK5wAUURoPUg==
In-Reply-To: <20080108100818.GA17205@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69871>

On 8/1/08 10:08, "Jeff King" <peff@peff.net> wrote:

>> If you are introducing crlf = warn, that means you are declaring
>> that CRLF should be treated as a disease, and that should apply
>> everywhere, not just on Windows (which some people may consider
>> a disease itself, but that is a separate topic).
> 
> It's unclear to me: is such a warning only supposed to happen when we
> see CRLF _after_ we have determined that a file is not actually binary?
> Otherwise, it seems like we are punishing people on sane platforms who
> use binary files (although even with that check, I am slightly
> uncomfortable given reports of incorrect guessing).

In the context of EOL style, a warning or error should only be given if we
think the file is text.  Very occasionally we will be wrong about this, but
if the default behaviour is warn then that will just be a minor annoyance.
This annoyance can be overcome for a file or file type (with attributes),
per project or globally.  If the default behaviour were munge (e.g.
autocrlf=true) then we could very occasionally damage something, so I think
we can all agree that is a bad idea.

Greg.
