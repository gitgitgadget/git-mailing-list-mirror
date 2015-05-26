From: Paul Tan <pyokagan@gmail.com>
Subject: Implementing git-am -3 with git-apply -3?
Date: Tue, 26 May 2015 10:49:47 +0800
Message-ID: <CACRoPnQWAYPsVVP_ycjBgPVSM_Orx7QmJc96zL5ixRuqi=V_eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 04:49:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx4wE-000066-4n
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 04:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbbEZCtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 22:49:49 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:33397 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbEZCtt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 22:49:49 -0400
Received: by lami4 with SMTP id i4so58417569lam.0
        for <git@vger.kernel.org>; Mon, 25 May 2015 19:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Gcm8h0ZAVymkiCE3Jzk/mQpL9L1GTtyzwiwlIlhGA34=;
        b=sM2CV1/emsPzsfmqKp1shJH4G5vobwu6Q3rMV/+pM34/mePhZPb+/dXLgzy/XMiEJX
         vIxrGxXrmpl7qgZ0GuVmQjgDil6N0ue++1R8cpqibarGpFWYYmuXp74SZ+LXN4ROUBWk
         YgGzkuyDk5GcRdZzzcqR6J51G1GpYjIfWmUPwfgwpTaG/aooedgwx1P4bdf77fUZTk7X
         wCpKsvfvYXJdMWsH1jpDieMjg+8d3sfq/57G++MLMRA5uNs2LA86Ruh+BtEryNSW8Z2N
         8uHnR4BfYIajCOfERrjwWtNjI1mzWqQSbEY72F03MuaWMK/6RH7BG6svjS8wbPJDV8gU
         2TNw==
X-Received: by 10.152.37.9 with SMTP id u9mr237249laj.65.1432608587466; Mon,
 25 May 2015 19:49:47 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 25 May 2015 19:49:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269923>

Hi Junio,

I noticed that you implemented a 3-way merge fallback[1] in git-apply
that is meant to be similar to git-am's.

I wonder if it is possible to implement the 3-way merge in git-am
using git-apply. Are there any issues/deficiencies that I need to be
aware of?

So far, I noticed that:

* git-apply does not handle renames in the index.

* It could probably try harder at merging submodules (perhaps by using
merge_submodule()?)

[1] http://thread.gmane.org/gmane.comp.version-control.git/201238

Thanks,
Paul
