From: Jorge <griffin@gmx.es>
Subject: Bug: .gitconfig folder
Date: Wed, 27 May 2015 15:29:11 +0200
Message-ID: <5565C6A7.60007@gmx.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 15:29:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbOn-0003Xz-0Q
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbbE0N3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:29:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:51288 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbbE0N3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 09:29:16 -0400
Received: from [192.168.1.20] ([83.44.206.111]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0Lh7sF-1ZRU1l2Hpf-00oVJB for <git@vger.kernel.org>;
 Wed, 27 May 2015 15:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
X-Provags-ID: V03:K0:n2Kh8NOC6D5vidW9THSLStArjK8df14qFV1eyiD6+afZl/CXqpT
 ZEL1jFSRb4mN6ZCQy5W3yu96E4yH0jYWtNry91xlVd2+PopR3Jw9zR6w9LQsdNyNwIiQX+f
 MUArg4aerw2WwYYiGtfxUBO0qxTiNzYqLiDpaTKfvyD2vnQQrSrV4pOLLw14K9V2qksADIg
 wZCv4jP37Foi4D3meIVig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jtG+S/pZfSk=:ISzJu6l9ePpsmfwuMheYUZ
 sxOepCjrp4CeQcdbJvnq5m3CLOaA/91RTVjywe2RA6Dn8lDguwIhq4HXhexAGzRonf86YhLqS
 Eh0Jqpts6Zw0rrQfLgmuo2XzvZDY7ZFpZrBhkxXxMB6NmzVV8TAM+8X2/DKs9/ov0m1tEikX2
 Vrtw6ap8wx8yTJ8h+7Q6sJTJ09JqyViO7RVTgpxfUqbk7Ft7TyBcG/D8ukNdyqmLYGm2228RB
 1N3P2Ha7xlPoEfl4V1epYFGEP3YHzW/geeKST4Wz3oRUB0QqQr19IP4ng863LdY/v4AcUSA4V
 z0igmBVtbQ8knOwEPBzOTDxokfP274fPiBSKBz60AEVSbIrL/HKUcjTiV2Ej5hhLkKCxHBBXQ
 vLOF5s5vpsbea+f2fylXvDNW4S8TJVJ6rF3Mg5QS4zLmTTEN2IVATB0ssMp/T6KB96Ow/oegj
 DVvJ8C/G/91YcUn5W9oYAsSG/uW35JgHSjpaGOISkKmVEiixwiq/G8iJH5TLINdofLMH7A9d/
 homYtKBLK5vIzZfNjTZFH0MeQmN/s1vzCoYv7gjQHgsYlhXMsOAmLWLPETqSioNWir3g/de1z
 JHKRzHQVnGIfx/dXZb5iB3shEkLTZ2E4Oe/I9xY7O4IWwxBQlzuflmgXXR6zf5DXnKSrnOfOn
 eEycF4xlrzyPhimvwnRUjV0NnTZOLym/wTP1sD5TXo/Qnezy0FHC7vCv1+BH0dH4dGqw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270046>

If you have a folder named ~/.gitconfig instead of a file with that 
name, when you try to run some global config editing command it will 
fail with a wrong error message:

     "fatal: Out of memory? mmap failed: No such device"


You can reproduce it:

$rm ~/.gitconfig
$mkdir ~/.gitconfig

$ls -la ~
     ...
     drwxr-xr-x 24 hit  hit       4096 may  4 12:30 .gimp-2.8
     drwxr-xr-x  2 hit  hit       4096 may 27 15:26 .gitconfig
     drwxr-xr-x  6 hit  hit       4096 may 27 14:01 github
     ...

$git config --global user.name foo
     fatal: Out of memory? mmap failed: No such device

$git config --global core.editor "vim"
     fatal: Out of memory? mmap failed: No such device
