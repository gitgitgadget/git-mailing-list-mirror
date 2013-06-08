From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/2] Move sequencer
Date: Sat, 8 Jun 2013 05:26:00 -0500
Message-ID: <CAMP44s2VpqTDW0GzNMmEmxt-VVwnLEyTjHLV9MQhqd2yqpYFDA@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0nbC3jfapvJKuh=m3s1n+GWfTYbhb5DWEjNrFDimQF-KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 12:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlGLY-0004zb-EZ
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 12:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab3FHK0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 06:26:04 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:42956 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab3FHK0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 06:26:03 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so47708lbd.29
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sXZKMgESINvSZakP2awfrjh6xVLmwIx5T/gGA1Y96jM=;
        b=Ly0CS27+ATAAHICucjyqrQxUwKdg6aL3i3nK5G0pP12kjmaet2bkjWu65gLu01Zfb4
         Kik1PqXBMcZ4u442Gszd6DyCg9jAtLId+P8NDiWHakDGc3jGt0kqOweea8jkuC1vyJQI
         rOcb4FUP264h1rs4GwIjfaFWmnoXZMzi/OkqXMDLp7xo5CMjKK1CiVMwu1zC09s061TN
         3ewFVvVkRttbaASsW/V9undKGdCbuz8IKef7r+AWlLTB0QAckkHlkEFOb8LmHoCAmL2h
         hpMrn0NX++ZftscZo/MRU2U3DERtHaWaMBuIzpLq13UUmSWQQsUwybG+O1qnkx18IRZ7
         KRwQ==
X-Received: by 10.152.26.225 with SMTP id o1mr1136129lag.43.1370687160857;
 Sat, 08 Jun 2013 03:26:00 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 03:26:00 -0700 (PDT)
In-Reply-To: <CALkWK0nbC3jfapvJKuh=m3s1n+GWfTYbhb5DWEjNrFDimQF-KA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226799>

On Fri, Jun 7, 2013 at 10:35 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>  sequencer.c => builtin/sequencer.c | 160 +-----------------------------------
>>  sequencer.h => builtin/sequencer.h |   4 -
>
> Why exactly?  The plan was to unify continuation semantics, and get
> all the continuation-commands to use the sequencer.  That clearly
> hasn't materialized, but I don't know what this move buys us.

So? The sequencer is only used by builtin commands, and other
continuation commands are also builtins.

The sequencer needs to access methods from builtins/*.o, so unless you
propose that libgit.a includes all the objects in builtins/*.o, this
is the way to go.

-- 
Felipe Contreras
