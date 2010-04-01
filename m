From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH 8/7] Make =?UTF-8?Q?string=5Flist=5Fappend=28=29=20consistent?=
 =?UTF-8?Q?=20with=20everything=20else?=
Date: Thu, 01 Apr 2010 21:07:30 +0100
Message-ID: <a93915db4a7615fe6b4c8e3f890db45f@212.159.54.234>
References: <7vzl1qwfno.fsf@alter.siamese.dyndns.org> <1270103379-3686-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 22:07:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxQfx-0005fB-VC
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 22:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758823Ab0DAUHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 16:07:33 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:59094 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758810Ab0DAUHc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 16:07:32 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 1F53B819C471;
	Thu,  1 Apr 2010 21:07:27 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 863DD20C801;
	Thu,  1 Apr 2010 21:07:30 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9LaqDHVTihuT; Thu,  1 Apr 2010 21:07:30 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 242C120C5EE;
	Thu,  1 Apr 2010 21:07:30 +0100 (BST)
In-Reply-To: <1270103379-3686-1-git-send-email-bebarino@gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143746>

On Wed, 31 Mar 2010 23:29:39 -0700, Stephen Boyd <bebarino@gmail.com>
wrote:
> string_list_append() is the only function in the string_list API which
> takes
> the struct string_list as the second argument instead of the first. Swap
> the
> ordering to make the string_list API consistent.

The only function?  It doesn't seem that way ...

jp3@rayne: git(pu)>grep '(' string-list.h | grep -v '(\(const \)*struct
string_list'
void print_string_list(const char *text, const struct string_list *p);
typedef void (*string_list_clear_func_t)(void *p, const char *str);
int for_each_string_list(string_list_each_func_t,
struct string_list_item *string_list_insert(const char *string, struct
string_list *list);
struct string_list_item *string_list_insert_at_index(int insert_at,
struct string_list_item *string_list_lookup(const char *string, struct
string_list *list);
struct string_list_item *string_list_append(const char *string, struct
string_list *list);

I don't think that swapping the argument order for append is wrong, but it
doesn't seem to be the only function that doesn't take the list as the
first argument ... or am I missing something? (probably am)

-- 
Julian
