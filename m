From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Help a sed noob
Date: Fri, 3 Aug 2007 19:22:48 -0400
Message-ID: <fcaeb9bf0708031622w25ab6e9ev61372169cfc0bd98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH6Tt-0000Zc-LS
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 01:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbXHCXWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 19:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbXHCXWu
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 19:22:50 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:43686 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXHCXWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 19:22:49 -0400
Received: by an-out-0708.google.com with SMTP id d31so184754and
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 16:22:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MyVoJElZjtEQyvtq3BSop4WFtbIIIa2PhZpWJlvwEmE3Ne06LvGrLGgnKUbEuikCiJoa+63Uhsgq3VxZS1I4cwIL+8UHQJ4RWt8RdR0wCl2UNZ7sqU1/Ij5lvNjPw1qfow89Sx2Z/5oNx3XnpdSQxEVXOLr1Vo6FJ19etCqHLm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rUsow/oVWa/VqMdlyHp6lHug2XvKsLogBCYT3rZOhfJ98gmIUtD1fyBM70K8IGrzUSyyxLC0PqY7JcCftoVpLMdSV2Eyl99t0NUfY9mQStIq4iHT4EjNHR4A8ZqxNAIpgaSUKeI0gGyXHCazqFsVTb9kaTv2QjhmA1n6Rn2bl3k=
Received: by 10.100.195.10 with SMTP id s10mr1053214anf.1186183368984;
        Fri, 03 Aug 2007 16:22:48 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Fri, 3 Aug 2007 16:22:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54767>

Hi,

There is a construct like this in git-parse-remote.sh which makes
busybox ash unhappy:

                sed -ne '/^URL: */{
                        s///p
                        q
                }' "$GIT_DIR/remotes/$1"

It complains about "no previous regexp" while gnu sed is ok. Can
anyone explain to me what does "s///p" do? GNU Sed info page says
nothing about empty regexp. If I replace it with "s/\(.*\)/\1/p" then
I get "URL: " along with the remote path.

By the way, can we use another construct instead? It would be less
work for me ;-)
-- 
Duy
