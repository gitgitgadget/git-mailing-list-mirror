From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] Fix t3411.3 to actually rebase something
Date: Fri, 18 May 2012 10:15:32 -0500
Organization: Exigence
Message-ID: <20120518101532.0c0c9dcf@sh9>
References: <4FB65345.3090201@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 18 17:15:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVOu9-00088v-H1
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 17:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab2ERPPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 11:15:39 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:62033 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab2ERPPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 11:15:38 -0400
Received: by ghrr11 with SMTP id r11so101950ghr.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=aQWAvjPhrgKj0oas32i8a1jLrD0M0tZmg4xeSd1YDdM=;
        b=FP+EHvlF5agg6Uf716bqzMIuadcWxIW0Kwy/ABH3CL5Q+9R3TcJrpR6NN0815SAOz8
         2RPdnqQfuXDZoo3Kej2n1021RyQc3btXc/bo+U2EeeUCmJu4aw2sfFCfuHCUq7L4giB+
         DY6akIpm2d4FrRAth6DNBznp+e24R+XpI5LDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:x-mailer:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=aQWAvjPhrgKj0oas32i8a1jLrD0M0tZmg4xeSd1YDdM=;
        b=blsElmzNkQLHZJ8Z7CWu+hz0nuZtmlJFafhfB9GblzcV1XHWiJDmiuU4NdECF4TxnO
         PEzZwdprrVhBsN39CKR3FZrYAXhYUUxfYTP4RT927f1N1nE2MKcaTf8PsP+au9/EEZJv
         CnY5Mb+UMQqQdR6WmzpLNe8XCFLbhVA5NSW9asYEZAM+QoTfJC9EN/GPogL/EmoPd6dX
         fwDJGWcT77+HSHwRXjSp8y7EON2b0BRJijuCU5FZoa4tJR/5M/w3W+SpbGd9+7ldyMUp
         ddPYnVNiKE+v+Vxhm2Zl/IYiuMwOXOno7zZ04q9CXuOZfhbU+O1/X/bip4kLkIDPOGud
         4IEA==
Received: by 10.60.25.100 with SMTP id b4mr1233415oeg.64.1337354136343;
        Fri, 18 May 2012 08:15:36 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net. [184.187.11.226])
        by mx.google.com with ESMTPS id a6sm6191368oeg.7.2012.05.18.08.15.34
        (version=SSLv3 cipher=OTHER);
        Fri, 18 May 2012 08:15:35 -0700 (PDT)
In-Reply-To: <4FB65345.3090201@kdbg.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.6; x86_64-pc-linux-gnu)
X-Gm-Message-State: ALoCoQmKQueWxvi0mOnkAA3rCR7KzcpLb/fiO+SCbzclugeNsQJJdCe2+iKHJ5ohtdQiqwMzD7Wa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197956>


> The test intends to rebase a branchy history onto a later commit, but
> it forgot to reset HEAD back to an earlier commit before it set up
> the side branches. In the end, every "rebased" commit was only a
> fast-forward and the 'rebase -p' did not change the commit graph at
> all. Insert the missing checkout that moves to an earlier commit.

Makes sense to me. Thanks, Johannes.

- Stephen
