From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 2/2] git-am: add --message-id/--no-message-id
Date: Wed, 26 Nov 2014 08:06:14 +0100
Message-ID: <54757BE6.2070103@gnu.org>
References: <1416924056-29993-1-git-send-email-bonzini@gnu.org>	<1416924056-29993-3-git-send-email-bonzini@gnu.org> <xmqqbnnusvmd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 08:06:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtWgB-0000r5-Ab
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 08:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbaKZHGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 02:06:19 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:50410 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbaKZHGS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 02:06:18 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so3867474wiv.7
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 23:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=i4QZCaE6OL5rUmpiNF4NNrBwbuWROO9hjQW8Jx18Mq8=;
        b=Qim9wLznPi0MJWKriiUtdxTDM26XXFf2EBbpRDVIyrBmzGApGbN/TyxE8C/ZkR0CH9
         0m8Lcf0mqfUYBfWbfJewRHbCxmwiVEY9Z4gG0L3jdOf99BjJAYlxTyK9x4qh58Y6oMpy
         xCIKp8N61UsXZTgfBByh0G+DG9NcYv9/NroDh5MbGRrb1CgtSyyBDBA5RWbwiOfKSVCu
         zlPJhsoNgQ+ws34vy+er0BBkiF09edYnaF9e6P4AD4LW5cUgSP1jPU9eC3/vHoe7uV48
         ju4Yc7/kuN/0RVV2w1CWaAD0P9GVv6MALTIyPj06/WzguhhAj+w+6/K4rK1/F1Q2pAP/
         G+Jg==
X-Received: by 10.180.20.234 with SMTP id q10mr11575103wie.53.1416985577569;
        Tue, 25 Nov 2014 23:06:17 -0800 (PST)
Received: from [192.168.10.165] (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id pl6sm5955543wic.22.2014.11.25.23.06.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 23:06:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqbnnusvmd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260273>



On 26/11/2014 00:34, Junio C Hamano wrote:
> ... makes the result look questionable.  The variable is initialized
> to empty; when it is written out to $dotest/messageid and later read
> back here, that empty value is not covered by this case statement.
> 
> Perhaps clearing messageid= upon seeing "--no-message-id" and using
> "'t' or empty" makes the code a bit easier to follow?  I dunno.

Possibly.  The other side is that it would be handled differently than
scissors and keep.  Changing everything is possible but would break
continuing a "git am" operation across an update, so I chose consistency.

Paolo
