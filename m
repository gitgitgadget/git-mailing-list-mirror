From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Fri, 9 Aug 2013 10:28:27 -0500
Organization: Exigence
Message-ID: <20130809102827.3c5d09fa@sh9>
References: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com>
	<1375983492-32282-2-git-send-email-stephen@exigencecorp.com>
	<alpine.DEB.1.00.1308082314320.24252@s15462909.onlinehome-server.info>
	<20130808163539.0b59b20a@sh9>
	<7vd2pn977v.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.1308091618530.24252@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 09 17:28:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ocE-0003Ue-K5
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 17:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891Ab3HIP2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 11:28:31 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:39181 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964779Ab3HIP23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 11:28:29 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so6392152obc.7
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-type:content-transfer-encoding;
        bh=dQi/F5nfp4rTNmkaZQBuYquXQKcamkE7avbA3iV5b9M=;
        b=CFkVIuU3yqiGqgwHQA8r/Y7AvIhzT5YuPaqEAcuyB6EEhKKXCW5Lztc9SpcavCD5qe
         FJqNrrRvVWkuGQsELRAi3c+IBiN7eCSme/F1SmgjhpI2Ca+30+RBOfzCh4ULN/oage3Q
         Jmgev9QFrbus288+yJmQHJjgRLfN6BAed8L8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=dQi/F5nfp4rTNmkaZQBuYquXQKcamkE7avbA3iV5b9M=;
        b=HQm+X8cOt0DYaKa1qtcmMP9x2UuzozX+cJKXDxA5x60ryDUcoF14qb//j+3lssk9iS
         iVaB/OZDhOxPSmyQvtB8cVg4N0zbY9jiYPuRzl2BSKVYkdYbcrpIF3jJGKWmCCejU/lp
         YF8pTvK0/PRj8znsXW4TlpgaVNurBmy6mPaamfo1hBUOCJlh3UDRNZPysuL4gmok7eGa
         9pVNH9OhWCIVEuFNDhVL3dlRd6Ba9lpBLHIoqKRA6EE1k6smzyvCtjuNbnqpis+5ogNg
         it7Otpae8EBs7W1WDjcCUyfXmkdTlUxzxJYzOapv4yYB1nQ5zf5K/y3HDlhR/Npnob6t
         NylQ==
X-Gm-Message-State: ALoCoQnIo3+r7cEZcwJJGddloGD4fKt+gSz2xasVQOY50NMQQVY/73evXy3QnNSwZCWj9A6384OP
X-Received: by 10.182.236.169 with SMTP id uv9mr910506obc.59.1376062109094;
        Fri, 09 Aug 2013 08:28:29 -0700 (PDT)
Received: from sh9 ([205.202.240.244])
        by mx.google.com with ESMTPSA id z2sm19357504obi.3.2013.08.09.08.28.27
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 08:28:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1308091618530.24252@s15462909.onlinehome-server.info>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231989>


> We have a patch in Git for Windows allowing rebase = interactive
> which I did not have time to send upstream.

Cool, so, would rebase=preserve and rebase=interactive be completely
orthogonal?

E.g. do we have to worry about the user wanting to do both, like with
something ugly like rebase=preserve-interactive?

Assuming not, rebase=preserve sounds good to me. I have a patch
that does that about ready to submit.

- Stephen
