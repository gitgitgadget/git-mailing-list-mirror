From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Implementation of git rebase --status
Date: Tue, 26 May 2015 09:20:38 -0700
Message-ID: <xmqqiobfl38p.fsf@gitster.dls.corp.google.com>
References: <1086316854.1201217.1432650834727.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<2024498388.1201300.1432651081110.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	Remi GALAN ALFONSO <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Louis-Alexandre STUBER 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine DELAITE <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 26 18:20:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxHax-0008Ex-Cf
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 18:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbbEZQUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 12:20:42 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38173 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbbEZQUk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 12:20:40 -0400
Received: by igcau1 with SMTP id au1so57306074igc.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ni8wESslAIk3yLYGwZWi9PJlK8AiHMX6yqZ/NRR88BY=;
        b=PYl66GwRqNDBpYSjBvEfy1ulh8DWhkfyJCO1nOAPbL3Crf3auBoPxBmenyrdbPUJg0
         tz9wTLrqXJdAasALHbA4cWAoOAqcksfKTeMjNtyekJfR0DB+vNRkEjcpVthDoMVKh3EP
         qlkaFxxQvkBMtTu4vrC4iL/FlFu5KBIDwNeVv9rwoJAlYqeK5/ixTIJuOI9tmo7/gvlr
         YZLXiu8taKjyoPPo+BjrodGpmLVLlA31NGti2VLtllcbVYhOtHlNchkeW8Ci4cjm6mEm
         9TQ/aITUW7ztYY5r5eo8TbrpBYkWJFx+UjhMq+d3fYSPp29zvzOzO/6OyasAiioJzYbs
         F/eg==
X-Received: by 10.50.80.19 with SMTP id n19mr29519928igx.30.1432657240236;
        Tue, 26 May 2015 09:20:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id o15sm8645198igw.11.2015.05.26.09.20.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 09:20:39 -0700 (PDT)
In-Reply-To: <2024498388.1201300.1432651081110.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Guillaume Pages's message of "Tue, 26 May 2015 16:38:01 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269949>

Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> Do you think it could be usefull or do you have any suggestion? 

All of your examples say things like:

    > You are in the middle of a rebase session. 
    > The line that paused this session is: 

but what if there is no such "line"?

IOW, what does the user see when using this new option during a "git
rebase" (not "git rebase -i")?

Other than that, sounds like a neat thing to do.
