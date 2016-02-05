From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v8] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Sat,  6 Feb 2016 00:28:55 +0200
Message-ID: <1454711337-25508-1-git-send-email-alonid@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 23:29:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRosU-0001SP-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbcBEW3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:29:18 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37817 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbcBEW3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:29:17 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so46242355wme.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 14:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZBaW01mDpWy0MGFYNiCf/YFmTRTkjbass6dI5wGhjlg=;
        b=Pqf+2SfdT8cuMrtxa0az1EXKYrrr9BpEKqzVR6ebbxVSu3iCVc5mKVhygJ/8r1ZwQo
         ihAQjldGByOQNUj7F5vzvLJz4paT2CzHdyiFk3Vkb2hjdqtk2TaF4D3sYuDTqm54fs4O
         WdjbGvpRLfqHpHp3ItiKRmkiUozWkDhjlj4VRtAlg1KIqO8YUu8gO36Rhlt+4T8SNAbQ
         mKCHOmlTylvhEROE+dc7IiqzHniCIycPnYXkEd0ppkDT3dySCzowg9AiSdE9P0gtCdMs
         U3w26/8h0i2yh9AOVn6ebPipjTKhX+AXWDBEyKcnk5xeL59M+0jkeA5rYFzoVfEMrRL0
         tjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZBaW01mDpWy0MGFYNiCf/YFmTRTkjbass6dI5wGhjlg=;
        b=PJJA2pqm6bkpnyqEh8UfOQjtuO0+YDmzLVAwF67750YaHzXuuVq6fvojZ1/S5gyGj9
         wq6QU50CgOFDmXViJRGzrrpHtlo2TEoF9ZQpqjtoksnUB7r5YZ7qYB+hcCgmMYfLESfk
         by5fgzeQ8djkcEhBJFLHub2vy+0PFCh65JJYx7JFepzyPj7y1hPxWxmulxVdKyhkJXUD
         prNM0HLuH4xI3qAM//VNjYOUnqHh7ge5/z8cVgvn//ClwtHGzY8PlcSjib8QHI8U2BDq
         ze5oKVjgOYH2Tes8EPpb3z7Oo2eaJ77kSZBW8d3wBWwsB09U6aSXiHX3uV9fyal1gqGr
         aTOg==
X-Gm-Message-State: AG10YOTbQi9u3/OXZqj7WK0iaUKbor/flul9Zvp5WZu4Jzbb/355hhEzgj7aEqWgvXhr9Q==
X-Received: by 10.194.243.103 with SMTP id wx7mr17734026wjc.136.1454711356479;
        Fri, 05 Feb 2016 14:29:16 -0800 (PST)
Received: from nitrogen.home.aloni.org ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id t3sm17729626wjz.11.2016.02.05.14.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 14:29:15 -0800 (PST)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285646>


Changes between v7 -> v8:

* Proofing fixes suggestions by Eric.
* Test script cleanup by Jeff.
* Renumbered test script.

v7: http://article.gmane.org/gmane.comp.version-control.git/285636
