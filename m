From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH] status: Add a new NUL separated output format
Date: Sat, 10 Apr 2010 21:34:56 +0100
Message-ID: <1702f7c7b0e0689149702335c9efad3f@212.159.54.234>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com> <20100410040959.GA11977@coredump.intra.peff.net> <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234> <20100410192529.23731.79803.julian@quantumfyre.co.uk> <20100410195003.GA28871@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 22:35:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0hOU-0003a1-U1
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 22:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab0DJUe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 16:34:59 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:37203 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838Ab0DJUe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 16:34:58 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 9EDF7819C6D3;
	Sat, 10 Apr 2010 21:34:51 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 2DE5B20CF30;
	Sat, 10 Apr 2010 21:34:57 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id E+I6y27xTVLc; Sat, 10 Apr 2010 21:34:56 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id B43C686FF0;
	Sat, 10 Apr 2010 21:34:56 +0100 (BST)
In-Reply-To: <20100410195003.GA28871@thyrsus.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144591>

On Sat, 10 Apr 2010 15:50:03 -0400, Eric Raymond <esr@thyrsus.com> wrote:
> Julian Phillips <julian@quantumfyre.co.uk>:
>> Add a new output format option to git-status that is a more extreme
>> form of the -z output that places a NUL between all parts of the
>> record, and always has three entries per record, even when only two
>> are relevant.  This make the parsing of --porcelain output much
>> simpler for the consumer.
> 
> If you're open to changing this to lose the exiguous "-> " and use "-"
> instead of " " as a status character, that would make me happy 
> and fix the rest of the design problems with the format.

If you use "--porcelain -Z" then you don't get the "->", the format is
always XY<NUL><file1><NUL><file2><NUL>, with <file2> being an empty string
if only file1 is relevant.

I didn't use "-" instead of " " as that seemed out of scope for a output
formatting option.  Though I don't personally have an objection to it, I
also don't see a particularly strong need for it as with the -Z format
there is no ambiguity.

If you're talking about the output without -Z, then changing the format
raises compatibility issues, and were talking about something more like
--porcelain2 or --porcelain=new and I don't know if that would be
considered acceptable.

-- 
Julian
