From: karthik nayak <karthik.188@gmail.com>
Subject: [RFC] git cat-file "literally" option
Date: Wed, 18 Feb 2015 15:09:35 +0530
Message-ID: <54E45DD7.205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 10:39:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO16j-00062t-HX
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 10:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbbBRJjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 04:39:41 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40263 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbbBRJjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 04:39:39 -0500
Received: by pdev10 with SMTP id v10so50335907pde.7
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 01:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=k/nsh4PGyVMjgpgqbE7Oqoa7d5afEUeHpwcowMQNi1s=;
        b=Q2gLFzVX0LL72iBwNndQ3f82j6cTlPjxbqRNww3l8DDYbBl9gMOENVEM7yhUjx8Fl1
         46Prk0U6PSiEmMJREX/3O2oIiFVcaaUyQfvShyZZDrNy3d0m3nJodwGUrzTLVn8G9PDL
         ISOUNHNuN3H9sb2252HGkQ11u/4TJN45pmPwtUacEUAMtVx0pug1WFngg4VQgPXKrY8N
         58D/4UqozM3FJT4R/24nOE4Em2tP+S0a6fGRLsVf46Y8AUflaBi2WZlDcTA+Ys6ZiUnh
         +DY68FV2I72AFVhK9CIQS7GR4jjQcBqVdE8NbRIJUev4reIbBFopBuDZCkcJsll7Zme0
         trdw==
X-Received: by 10.68.96.194 with SMTP id du2mr56459540pbb.107.1424252379008;
        Wed, 18 Feb 2015 01:39:39 -0800 (PST)
Received: from [172.16.2.128] ([182.48.234.2])
        by mx.google.com with ESMTPSA id ca2sm20000794pbc.68.2015.02.18.01.39.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Feb 2015 01:39:38 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264011>

Hey,
After reading http://thread.gmane.org/gmane.comp.version-control.git/256878
I have started working on the git cat file --literally option.

I'm wondering if I should implement it as an add on to the existing options,
wherein we could say "git cat-file (t | -s | -e | -p | <type> | 
--texconv) --literally <object>"
so that it would be able to print the required data literally or should 
I implement it such that
we could say "git cat-file (-t | -s | -e | -p | <type> | --texconv | 
--literally) <object>"
so it would just give all information about the given object. (Maybe 
like the -p option?)

For example :
if  I create a bogus object like

git hash-object -t bogus --literally -w --stdin </dev/null

Should I implement
git cat-file -t --literally 49993fe130c4b3bf24857a15d7969c396b7bc187
or should I implement
git cat-file --literally 49993fe130c4b3bf24857a15d7969c396b7bc187
To get information pertaining to the object "bogus:.


What do you people think?
Thanks
-Karthik
