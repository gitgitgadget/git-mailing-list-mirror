Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020134.outbound.protection.outlook.com [52.101.75.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DAF346AC1
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675556; cv=fail; b=sy00MY4n5b1HgqbPtriBScIa2oL5cnhsnaOwUz9gy/sU/v3pGQxWls6jQvPtzluZMUeuqMYXkylbwop1sPBEkZjGMsHKC7OqkgIL+RaaU/aaUWYlwvaY2r5z2R27jOXZN+eUiEKL5C7fYy1EhmzLqy5l3sT6qYJnALTyAo65psk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675556; c=relaxed/simple;
	bh=clVZhNgCbvf1H9v+l2p/UJT3uayGR4j8yRYf9YXUGZE=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=PLm2NpyRWbEOMFgMYroWcCe7hSHrKKxLyfExQ3595fIx0YHQQQhhc8kA5xEFy/Sm1cnnVjaEPekNJqSJ5UzKxLx0TXKMI7Kdb+8CazXqN394fwIKKGKgFYgsL0JI7cTrHMxocVtZgmmuIxw0Bl9o7Qb16XGa6zK+CyZCOPf7n1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sunet.se; spf=pass smtp.mailfrom=sunet.se; dkim=pass (2048-bit key) header.d=sunet.se header.i=@sunet.se header.b=t5YpOG+w; arc=fail smtp.client-ip=52.101.75.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sunet.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sunet.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sunet.se header.i=@sunet.se header.b="t5YpOG+w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S42qNUjaVl9ACvHmSmGRxE6yK7CCSfI2VeoECnZSC6D5qapEqOj4a/yL2TSMYp6mkSSg5nmxYZydQqI7Vs6vzzqAFJdmQbTXmlE8CzPEDjF2bs92Vb4VjqvEDyCNZbtNVx9SRdRfhzUFPciNsPkj3HrZ01TqB6TLuLWYuhQeE2tmRM8Qu83skwPJ67sRUwPHBYWidsUsupgOTGE+vQXO5/IGQZDYnndHapVTdfB2bxiAn42McNOAtlz80ttfXhTSqHSzHRYYsj1uhxqgucLlCsOFP0XKWh08Jzi1g8ngH7CpuuJ1CMNoovchOHAT8NwrpWmRDt/AOqOq1XT3fdl/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2zFqGWqehILSSepzfJov/VCMO4RGK8g1Oqw3bCnZ9Y=;
 b=B2wxk7tn6+V5bYV2sNFX/sbI3oF6Dqv7fvcsCvxYc/xHjzv8aPMGevMXUllr8xHW3hJp+9Z+U6utKQz8dXMe+GcxsjXa0+d8LHfKnCJ5YkmphlmC6sNuAqyawsIyMZ8sb3SHIALBQ2ZmO9eqQ6yKoUBWqDR4F+g4arAv3ect9XI9RUhvZr8AvscuSfBwKz6AmsFFHtkKhAUja8PuZOIFjdWhMJwGyspX3tSoa6PpJ2NPrHG39biHoxKPBpj6O+16g6iQnkjlBnCcOEHm2pIgOmdHLreGZSF1atuaqvXwAZ4rMRlaRhyCboNrrllRdiZP/7Dtqx3XRSzQh11+enwjAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sunet.se; dmarc=pass action=none header.from=sunet.se;
 dkim=pass header.d=sunet.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sunet.se; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2zFqGWqehILSSepzfJov/VCMO4RGK8g1Oqw3bCnZ9Y=;
 b=t5YpOG+w7r74OReSu2FdtGYP8cRcffqQIexiUQPnplNo6eHb0P42VrMA7biCGLIY50XiJzJDP/0UQw6K5jRq6OYzLNWP3g/NKqUq1xzHppQc7/XMhJByJ6sno2Lnc5IIyTvthCcchJPuNoMWbLqqr3VqIQ77rZwpmbPV+qaS2O4yzrHDCbDrQE0usy/Br+08jlYQ4lkZqIbempYZ53SxZClLw2IpTkap77yvWJ9i+UA6N8h8SsVFtKOKpX8xLXhwtmIRzhP5nqyQCXlLr92iOQhLN+lR1SXYEJoCXTzgEs/sw9R71sFbVqQDHpjr7dJ6lIgKBA0UMwRqcHZ6yzQBOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sunet.se;
Received: from GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:370::13)
 by GVZP280MB1878.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 20 Apr
 2026 08:59:07 +0000
Received: from GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM
 ([fe80::9ab4:ee3a:7036:5a27]) by GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM
 ([fe80::9ab4:ee3a:7036:5a27%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:59:06 +0000
Message-ID: <4d5d04e2-49c4-4781-a289-f8cf79570643@sunet.se>
Date: Mon, 20 Apr 2026 10:59:05 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>
From: Kushal Das <kushal@sunet.se>
Subject: [BUG] v2.45+: git commit -S invalidates signature for non-UTF-8
 messages
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0085.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::8)
 To GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:370::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVTP280MB2179:EE_|GVZP280MB1878:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d8b03e-5e4c-4245-673e-08de9ebb13bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|786006|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jk6FVkn5XGaL2E6mCMGQQzqn2WuVJBDRevYv7wWZVYXSzW0r1Iq8nnEpYRGVXPsi4y9yWzNFMWr8F1h5pUGBimz43+JpaPhthEf71qO8N0T+yWtTyVpi7IGtS6EpTFbZac4M48EKTExEBg5dTVyo8695HQ6Ejt2CVB/qHLyfGN8/3qgr5hegP7xjle/4kVX6AFvdbqHl2b3FruDms7SF+pzOhQ4WD3YdFjHEGAxV8qQJ0zyGq9HNr0NlJVFs8jdVP+BJIuG9sKrS8rms83F1CD1sfQMvzV6A9i6WuePqlyPlqYsBJFGP08eege+0yWQmF2erYCbXCpbcrO8MK8s14OpbmX/Oq5JdrVvYGrVI+doBRdZ+/KDqi78ynXpH8SuGIXhLEUwqpOlIz37/RjUf2tWOtQcJFvhNom1DR3Pv7oBtOcdbkHzR5NPlB9gbfIlsaP7Fv4t/YSeyjxswfPY79uMcch8fujvzW58MI/enwi4rFpwR3hfNwovGxItaOR7rIiIRuXDhHsSUXkroPXeEB31YGZQlUj0dmSt+VY3bfxarmCL53vqIyfjD/3S/GcZV/w3CP3jppWdHH9X37IjOG22LcGJ73DRo3xIK5pqm61IVIpaK1yLk2mFnTxhOGg6f5UHt0JCsze+p9PXgabg0rZ5Yr5vpsPCisVsbZxHhYhY6I0qdBFyCPE8NNXr9meydbuphD2dv8aEu1UU6rKdEvupuz2SU2LcnH8OCyyrei08=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlB3NXp2ZDlNMFFBbjNxQU44NE04enBkK1RSZDZzMGFmKzVIbGRxbXg3VkMx?=
 =?utf-8?B?ZG9tb2hFcUFQU1hLVmNMK0NtUFpGYTU2UUo2KzFnWlVwTkduRGozNlo4Yy8x?=
 =?utf-8?B?bkZvOThwTnNkcC9IcncreXJ5MFR4RXZxRW1DR2Q4c0xCMzBTUlRNU3U2VjZv?=
 =?utf-8?B?MTZVbnpTcVVnQ0VIRUowcG0zOWNyRThpUnBtc1EvNUR3cUdMUnp5cklmR0xu?=
 =?utf-8?B?ZUo3Q2QrYjZOVDlTOVVMTjV5dWhIbVlsNzV3MHE4L2ZQanR6QjdySWVBU1F6?=
 =?utf-8?B?Y0cwTy92WVpWRStrcHBMd2NleWNWNDFoZ0lUdUdXOEt3Y2wrQkdRNWcwNTRu?=
 =?utf-8?B?aVFOTkZZNXRRVURtei9lZktsa3pMTk4xQVVZVk1RbW9IcFlyR0ZkUFRUVjIx?=
 =?utf-8?B?K3BpS0xsMVJxa2hyOTBPSlBJLzlyL3orL0Q5dXh5S0FsaDFDZkJQWS9vV3JW?=
 =?utf-8?B?WitOWC9OM3F4UEVGY1RTL2crMUR0YzBCQmEvYkZ6UGduZ3BkSlB4ekh6TG04?=
 =?utf-8?B?bFdlSWE0SzN4SUVlSXNHenJKZlZSV0NzdC9CK0pzbEtLWXB5WmY2d0FHV01G?=
 =?utf-8?B?eWxBY001QUExd3FBZm0rRG1PakhOcGcvMWtHbGQvdnQwK0l3RnVUSFZtV1d4?=
 =?utf-8?B?bEp6bzFxalB6Yzhnd3Q3ZUhDUExQcWRac2tHL1Q0ZFNxb2k5a1Q2NW9LejMr?=
 =?utf-8?B?amYyRG9OdmxyeWhIalJBYkx2a1RpK3Jyb3hpU3lxT2dUd1l1T1hLK1lYcmFt?=
 =?utf-8?B?ekxXellsSlVhTzRzRHB3eG5jTnp2MjFpbU4rL2NrT291TnJXR3JxTXBucUNV?=
 =?utf-8?B?M1J3RDBFZXc0ekl6TW1XQTNER1BqYzF0YUhIU1YrR2VKREhRL3Yrc3FUVnpx?=
 =?utf-8?B?djdBaXNnb2VIUitqbFJ0MFFEN2c2aDlVeUVETW85d2RmNlgyd0pKTmdzSFk4?=
 =?utf-8?B?VWtWY3phakt6Z1VqQUw0K0dGeVJBQVdoQWFlU2ZmNFpBMlJTeDcvMEsyODhk?=
 =?utf-8?B?RWN2VzhtZFgveWdsVElGaEN4VHJ3bzlnS3V2c2tpbzZ5T0xjZVovQXNYZ1RM?=
 =?utf-8?B?TVpvRnFMais5eWMzUkhsVEJqQTJBUkJMTEtQS0JwNzZpNjZHdFBOQkREY0h1?=
 =?utf-8?B?M3pqT2hERVRSZUhRaXl0Q0k4ZHA1YlNkUmtPaEhwdm4wMWQwTEpiR2YzQURC?=
 =?utf-8?B?ZjhhMEExSm9MUTJFNlVPL2FWZ056R0hSbUV1dHBlaCtla01NYlNPbVVNdkw1?=
 =?utf-8?B?aVphMzVQdnQrM1p4VjVPSFRMS2xKaGNJK0x6Wjg1TVZxVG1Ic2d2cktqeUli?=
 =?utf-8?B?d0RicG1wNHdxZm9hNmJ3U0VsQ2J5RXMrM2NRWElJZmNSUC9xbFhjbk9Nd0cw?=
 =?utf-8?B?UXY3OEZiWHdMQ09wTmR5UHN4dit1REJKc0pRNkx1TkNqV1Z2V004a3RwcXF4?=
 =?utf-8?B?RzUxbk9rUi9VNlF5MytRQW9xZDFKbWNmWitwTHIrOFlxbUlkOHU4RkZFaGRj?=
 =?utf-8?B?U1dnVUU0T0Y4eW9UVzU5aXF0MmZRU0N2R0VOT1RxOXpMREE4RUxYUld2VFdV?=
 =?utf-8?B?R0JqaUJabnhLb25CSWsrbTNkdldCWlpvZ24xSU9GVE1YRmYxVUNiTXF1eTlF?=
 =?utf-8?B?MjJBaXNrRmJacTNjK3RCOWQvU3RtUGYzZTVGRklFTnFSVGVnOGJuSkxyZk94?=
 =?utf-8?B?UnRXMjBvS0VDNWo3SngxQWJZNE9YYjU3ZHRtVUFZODV5bXNJVFBQeGNoYmZ4?=
 =?utf-8?B?R3hnREowWVhzVEhRZmw4cVJyN1RGK1JraFdRc0F1SGpHU0VUOXJtMVNocXJz?=
 =?utf-8?B?RzNQbzhtRm9reDNFVjN5TzZHemRnRXRHcEpjdFpjMEIvZFhhUkVPQ0E1S3F5?=
 =?utf-8?B?d3pyb0pjcC90VDVGQWdoRjFOT3BlR29WR3VROGtQRjMxakhqU0U3RHc4VjdI?=
 =?utf-8?B?dm11Tk5WRjY2WHp6RHZhcHlOMHhUNjdKeGdqVjlUWGdFSnN0eGNvZ3BzNXBs?=
 =?utf-8?B?Rml1N2xtQ0tweWczdmlEQm5rSmFRT0Jic3JZUDNkODNHdm9LaFg2aEZIZktK?=
 =?utf-8?B?UTluVk9uQU5OY2dNKzk5QXM3c2Exc2hSYThINzc3M2pQKzVwKy9QeWtGdHdV?=
 =?utf-8?B?Umg1ZXVDR2I2Q3RydThHRlE3YXFRdWdVS3FJbWtqSXFLY2U4M0xuK05xSHF6?=
 =?utf-8?B?dmFVWnhITTlUVzBOck9FSWJsU3lITTZuOEt0eFZ6UzBSNVZBWkdhN1pMNlFM?=
 =?utf-8?B?UWRxZkN5NGE3Z2wzeFhLT3Z1aHdmNGF4V2Q2dXduREVFNEdBRm1KTVozNnZ1?=
 =?utf-8?B?TXdDQy9VOHN6WTNNZ3JUY1hwY0xtRmFqMWgyMW5vN05EMG1VM0E1Zz09?=
X-OriginatorOrg: sunet.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d8b03e-5e4c-4245-673e-08de9ebb13bc
X-MS-Exchange-CrossTenant-AuthSource: GVTP280MB2179.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:59:06.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: beb73af0-54c3-4c95-886a-3e6de3a76471
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iHha7rkjQHj3j68MS1HNbIZrhuaypqsxz177DInNkbSm8P+1GTjc1kyXmY3Jhbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1878

Hi all,

Every `git commit -S` since v2.45.0 produces a permanently-BAD
signature when the commit message contains bytes that are not valid
UTF-8 AND `i18n.commitEncoding` is unset (i.e. the default case).
Verification fails under both `gpg --verify` and any non-GnuPG signer.
The failure is deterministic: it happens every time, on every
non-UTF-8 commit, no card or external tooling needed.

My best guess is commit 6206089cbd0b1cb30a017ec904567f040ab4cea0 
starting this (and I am maybe 100% wrong in identifying the cause).

In pre-6206089cbd `commit_tree_extended`, `verify_utf8(&buffer)` ran
BEFORE `sign_with_header(&buffer, sign_commit)`. `verify_utf8` is not
a simple validator -- it mutates the strbuf in place, replacing
invalid-UTF-8 bytes with their Latin-1 -> UTF-8 two-byte form. The
signer therefore saw the transcoded bytes, and the same transcoded
bytes were then written to the object database. Signer and
verifier agreed.

After 6206089cbd, the sequence in `commit_tree_extended` is:

   write_commit_tree(&buffer, ...);
   sign_commit_to_strbuf(&sig, &buffer, sign_commit);   /* pre-transcode */
   ...
   add_commit_signature(&buffer, bufs[i].sig, bufs[i].algo);
   /* and then */
   if (encoding_is_utf8 && (!verify_utf8(&buffer) || 
!verify_utf8(&compat_buffer)))
       fprintf(stderr, _(commit_utf8_warn));            /* post-sign 
transcode */
   ...
   odb_write_object_ext(..., buffer.buf, buffer.len, OBJ_COMMIT, ret, ...);

The signature in `bufs[i].sig` covers the raw (non-UTF-8) buffer. The
`verify_utf8` call after `add_commit_signature` rewrites the message
portion of the stored object to UTF-8. The object that hits the ODB
therefore contains bytes that no longer match what the signer hashed,
and any verifier that reads the commit back and re-hashes the
sig-stripped buffer will find a mismatch.


As a reproducer I ran the following command with the below bash script 
to verify so far
`podman run --rm -it -v ./git_bug.sh:/git_bug.sh:Z fedora:41 bash -c 
'dnf -y install git gnupg2 >/dev/null 2>&1  && /git_bug.sh 2>&1'`


```
#!/usr/bin/env bash
# git_bug.sh -- minimal in-container reproducer for the git 2.45+
# sign/store divergence on non-UTF-8 commit messages.
#
# Two cases:
#   CASE A: default git config. On git 2.45+ the signer hashes the
#           raw (Latin-1) bytes but the ODB stores the UTF-8-transcoded
#           bytes. Verify fails with BAD signature.
#   CASE B: same commit with `i18n.commitEncoding=iso-8859-1`. git
#           tags the object with an `encoding` header and skips the
#           in-place transcode, so sign and store bytes agree.
#
# Exit codes:
#   0   Not reproduced. Git either predates v2.45 or carries a fix.
#   1   Reproduced. CASE A BAD, CASE B GOOD (workaround confirmed).
#   2   Unexpected state or missing tool.
#
# Dependencies: git + gpg + awk + od + a POSIX shell. the script mints 
its own
# throwaway Ed25519 key in a temp GNUPGHOME. Host state untouched.
#
set -euo pipefail

step() { printf '>>> %s\n' "$*"; }
say()  { printf '%s\n' "$*"; }
die()  { printf 'git_bug.sh: %s\n' "$*" >&2; exit 2; }

for tool in git gpg awk od; do
     command -v "$tool" >/dev/null || die "$tool not found on PATH"
done

SANDBOX=$(mktemp -d -t git-bug-XXXXXX)
export GNUPGHOME="$SANDBOX/gnupg"
mkdir -p "$GNUPGHOME"
chmod 700 "$GNUPGHOME"
# Pre-create agent + gpg configs so loopback pinentry works and no
# dirmngr / tty prompts can fire.
cat > "$GNUPGHOME/gpg-agent.conf" <<EOF
allow-loopback-pinentry
default-cache-ttl 3600
max-cache-ttl 3600
EOF
cat > "$GNUPGHOME/gpg.conf" <<EOF
pinentry-mode loopback
batch
trust-model always
EOF

cleanup() {
     gpgconf --homedir "$GNUPGHOME" --kill all >/dev/null 2>&1 || true
     rm -rf "$SANDBOX"
}
trap cleanup EXIT

PASS=""

step "detected: $(git --version), $(gpg --version | head -n1)"

# ---------------------------------------------------------------------
# Mint a throwaway Ed25519 signing key. Ed25519 signs in well under a
# second, unlike RSA-4096 which on some containers takes tens of
# seconds and easily reads as "the script is hung".
# ---------------------------------------------------------------------
step "minting throwaway Ed25519 key"
cat > "$SANDBOX/keygen" <<EOF
%no-protection
Key-Type: EDDSA
Key-Curve: ed25519
Key-Usage: sign,cert
Name-Real: git-bug-tester
Name-Email: bug@example.local
Expire-Date: 1y
%commit
EOF
gpg --batch --gen-key "$SANDBOX/keygen" 2>"$SANDBOX/keygen.err" \
     || { cat "$SANDBOX/keygen.err" >&2; die "key generation failed"; }
KEY_FP=$(gpg --list-keys --with-colons bug@example.local \
     | awk -F: '/^fpr:/ {print $10; exit}')
[ -n "$KEY_FP" ] || die "could not read key fingerprint"
say "key: $KEY_FP"

# Kill the gpg-agent spawned by keygen so the next invocation starts
# fresh with our loopback-pinentry policy.
gpgconf --kill gpg-agent >/dev/null 2>&1 || true

# gpg wrapper git will invoke as `gpg.program`. Branches on whether
# --verify is in argv so we can capture the two stdin streams to
# separate files without clobbering each other.
cat > "$SANDBOX/gpg-capture" <<WRAP
#!/usr/bin/env bash
OUT="$SANDBOX/sign_stdin.bin"
VERIFY=0
for a in "\$@"; do
     if [[ "\$a" == "--verify" ]]; then
         OUT="$SANDBOX/verify_stdin.bin"
         VERIFY=1
         break
     fi
done
if (( VERIFY )); then
     tee "\$OUT" | exec gpg "\$@"
else
     tee "\$OUT" | exec gpg \\
         --pinentry-mode loopback --passphrase "$PASS" --batch --yes "\$@"
fi
WRAP
chmod +x "$SANDBOX/gpg-capture"

# ---------------------------------------------------------------------
# Run one case: fresh repo, optional extra git config, sign a
# lone-0xa7 commit, dump the bytes, verify. Returns 0 on GOOD, 1 on
# BAD. Prints a progress line for every potentially-slow operation so
# a "is it stuck?" question is answerable from the terminal.
# ---------------------------------------------------------------------
run_case() {
     local label="$1"
     shift
     local extra=("$@")
     local repo="$SANDBOX/repo_${label}"
     rm -f "$SANDBOX/sign_stdin.bin" "$SANDBOX/verify_stdin.bin"
     mkdir -p "$repo"

     say ""
     say "=== CASE $label ==="
     say "extra git config: ${extra[*]:-<none>}"

     (
         cd "$repo"
         step "git init + config"
         git init --quiet
         git config user.name tester
         git config user.email bug@example.local
         git config user.signingkey "$KEY_FP"
         git config commit.gpgsign true
         git config gpg.program "$SANDBOX/gpg-capture"
         for kv in "${extra[@]}"; do
             git config "${kv%%=*}" "${kv#*=}"
         done

         printf 'section \xa7\n' > "$SANDBOX/msg.txt"
         echo content > f.txt
         git add f.txt

         step "git commit -F msg.txt (invokes gpg-capture to sign)"
         git commit -F "$SANDBOX/msg.txt" --quiet 
2>"$SANDBOX/commit_${label}.err" \
             || { cat "$SANDBOX/commit_${label}.err" >&2; exit 1; }
     )

     say "-- msg.txt (bytes we asked git to commit): --"
     od -An -tx1 -v "$SANDBOX/msg.txt"

     say "-- sign_stdin (bytes git fed gpg at SIGN time, tail): --"
     od -An -tx1 -v "$SANDBOX/sign_stdin.bin" | tail -n 1

     say "-- commit object body (bytes in the ODB, tail): --"
     (cd "$repo" && git cat-file commit HEAD) | od -An -tx1 -v | tail -n 1

     step "git verify-commit HEAD"
     local rc=0
     (cd "$repo" && git verify-commit HEAD) >/dev/null 2>&1 || rc=$?

     if [[ -f "$SANDBOX/verify_stdin.bin" ]]; then
         say "-- verify_stdin (bytes git fed gpg at VERIFY time, tail): --"
         od -An -tx1 -v "$SANDBOX/verify_stdin.bin" | tail -n 1
     fi

     if (( rc == 0 )); then
         say "verify: GOOD (exit 0)"
         return 0
     else
         say "verify: BAD (exit $rc)"
         return 1
     fi
}

if run_case A; then
     STATE_A=GOOD
else
     STATE_A=BAD
fi

if run_case B i18n.commitEncoding=iso-8859-1; then
     STATE_B=GOOD
else
     STATE_B=BAD
fi

say ""
say "=== summary ==="
say "CASE A (default commitEncoding):         $STATE_A"
say "CASE B (i18n.commitEncoding=iso-8859-1): $STATE_B"

if [[ "$STATE_A" == BAD && "$STATE_B" == GOOD ]]; then
     say "RESULT: reproduced. This git has the v2.45+ regression:"
     say "  verify_utf8 runs after the signature is already computed,"
     say "  so the signer sees raw bytes and the ODB stores transcoded"
     say "  bytes. Workaround confirmed: i18n.commitEncoding=iso-8859-1."
     exit 1
fi
if [[ "$STATE_A" == GOOD && "$STATE_B" == GOOD ]]; then
     say "RESULT: not reproduced. Either git predates v2.45 or has a fix."
     exit 0
fi
say "RESULT: unexpected state (A=$STATE_A B=$STATE_B)."
exit 2
```

Output:

```
 >>> detected: git version 2.52.0, gpg (GnuPG) 2.4.5
 >>> minting throwaway Ed25519 key
key: 5DDD17B4C7A2BB447EAC16F5280A03FBE5C7A8DF

=== CASE A ===
extra git config: <none>
 >>> git init + config
 >>> git commit -F msg.txt (invokes gpg-capture to sign)
-- msg.txt (bytes we asked git to commit): --
  73 65 63 74 69 6f 6e 20 a7 0a
-- sign_stdin (bytes git fed gpg at SIGN time, tail): --
  a7 0a
-- commit object body (bytes in the ODB, tail): --
  20 c2 a7 0a
 >>> git verify-commit HEAD
-- verify_stdin (bytes git fed gpg at VERIFY time, tail): --
  c2 a7 0a
verify: BAD (exit 1)

=== CASE B ===
extra git config: i18n.commitEncoding=iso-8859-1
 >>> git init + config
 >>> git commit -F msg.txt (invokes gpg-capture to sign)
-- msg.txt (bytes we asked git to commit): --
  73 65 63 74 69 6f 6e 20 a7 0a
-- sign_stdin (bytes git fed gpg at SIGN time, tail): --
  69 6f 6e 20 a7 0a
-- commit object body (bytes in the ODB, tail): --
  74 69 6f 6e 20 a7 0a
 >>> git verify-commit HEAD
-- verify_stdin (bytes git fed gpg at VERIFY time, tail): --
  69 6f 6e 20 a7 0a
verify: GOOD (exit 0)

=== summary ===
CASE A (default commitEncoding):         BAD
CASE B (i18n.commitEncoding=iso-8859-1): GOOD
RESULT: reproduced. This git has the v2.45+ regression:
   verify_utf8 runs after the signature is already computed,
   so the signer sees raw bytes and the ODB stores transcoded
   bytes. Workaround confirmed: i18n.commitEncoding=iso-8859-1.
```

I tested this in different ways.

- git 2.53.0 from Fedora 43 reproduces.
- git 2.53.0 from ubuntu-latest (GitHub Actions) reproduces.
- git 2.43.0 from Ubuntu 24.04 does NOT reproduce (v2.44 is the last
   tag without 6206089cbd).
- Any signer produces the bug -- tested with GnuPG 2.4.9 and with
   my non-GnuPG tclig [0]; both hash over the same pre-transcode bytes
   the command-line signer is piped, so both get invalidated by the
   post-sign transcode.


[0] https://crates.io/crates/tumpa-cli

Kushal

