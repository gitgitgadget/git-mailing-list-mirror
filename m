From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git attributes ignored for root directory
Date: Thu, 13 Oct 2011 00:35:18 +0200
Message-ID: <4E961626.4030201@alum.mit.edu>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu> <7vd3eb8hkb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Gioele Barabucci <gioele@svario.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 00:35:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE7Ob-0007xz-Su
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 00:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab1JLWf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 18:35:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52325 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777Ab1JLWfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 18:35:24 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9CMZISJ005577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Oct 2011 00:35:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vd3eb8hkb.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183426>

On 10/05/2011 07:38 PM, Junio C Hamano wrote:
>  - If the pattern is a single dot and nothing else, it matches everything
>    in the current directory.

This disagrees with shell usage, where "." represents a directory
itself, not the files within a directory.  By the trailing slash rule
that you quoted, "./" should also represent the containing directory.

Given that git currently tries to ignore directories and only think
about files, the consistent thing to do would be to declare "." and "./"
as undefined.  Because someday git *may* want to get a bit smarter about
directories, and at that time it would be a shame not to have "." and/or
"./" available to represent the containing directory.  (But implementing
it will require some special-casing within the attr module, which is
currently pretty stupid.)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
