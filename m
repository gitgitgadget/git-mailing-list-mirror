From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/18] rebase -i: Make the condition for an "if" more
 transparent
Date: Tue, 26 Jan 2010 13:38:47 +0100
Message-ID: <4B5EE257.8060204@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu> <aa37ee8a68d460df172b23b4999fbe4ce7d77c1e.1263447037.git.mhagger@alum.mit.edu> <alpine.DEB.1.00.1001251927460.8733@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 13:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZkjw-0005dI-5K
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 13:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab0AZMlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 07:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461Ab0AZMls
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 07:41:48 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:54341 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab0AZMln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 07:41:43 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0QCclln016662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Jan 2010 13:38:47 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.1001251927460.8733@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138035>

Johannes Schindelin wrote:
> On Thu, 14 Jan 2010, Michael Haggerty wrote:
> 
>> @@ -166,7 +166,8 @@ pick_one () {
>>  	parent_sha1=$(git rev-parse --verify $sha1^) ||
>>  		die "Could not get the parent of $sha1"
>>  	current_sha1=$(git rev-parse --verify HEAD)
>> -	if test "$no_ff$current_sha1" = "$parent_sha1"; then
>> +	if test -z "$no_ff" -a "$current_sha1" = "$parent_sha1"
> 
> Rather use &&, right?

Yes, that mistake was caused by my own ignorance about the portability
issues.  This problem was already discussed [1] and the change has been
integrated into master.

Thanks,
Michael

[1] http://marc.info/?l=git&m=126344857120877&w=2
